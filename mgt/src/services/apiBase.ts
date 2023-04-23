import axios from 'axios'
import type { AxiosError, AxiosResponse, CancelTokenSource } from 'axios'
import { camelizeKeys, decamelizeKeys } from 'humps'
import Jsona from 'jsona'
import swal from 'sweetalert'

import firebase from '@/services/firebase'
import i18n from '@/services/i18n'
import storage from '@/services/storage'

interface Args {
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  [key: string]: any
}

interface ErrorHandlers {
  [key: string]: ((error: Error) => void) | undefined
}

const dataFormatter = new Jsona()

const timeoutMs = 30_000
const largeTimeoutMs = 300_000

const baseUrl = process.env.VUE_APP_API_URL

const { t } = i18n.global

const httpInstance = axios.create({
  baseURL: baseUrl,
  timeout: timeoutMs,
  // NOTE: Rails の reauest.xhr? 判定のため
  headers: { 'X-Requested-With': 'XMLHttpRequest' }
})

// eslint-disable-next-line import/no-named-as-default-member
const CancelToken = axios.CancelToken

const apiBase = {
  // request cancel
  cancelSource: CancelToken.source(),
  cancel (this: { cancelSource: CancelTokenSource }, message: string) {
    this.cancelSource.cancel(message)
    this.cancelSource = CancelToken.source()
  },
  // get, delete -> (use params)
  async get (
    this: { cancelSource: CancelTokenSource },
    path: string,
    {
      params = {},
      header = {},
      errorHandlers = {},
      cancelToken = this.cancelSource.token,
      timeout = timeoutMs
    } = {}
  ) {
    console.log(`[GET] Request: ${path}`)
    const headers = Object.assign(await getAuthHeader(), header)
    return await checkResponse(
      httpInstance.get(path, {
        params: decamelizeKeys(params),
        headers,
        cancelToken,
        timeout
      }),
      errorHandlers
    )
  },
  async delete (
    this: { cancelSource: CancelTokenSource },
    path: string,
    {
      params = {},
      header = {},
      errorHandlers = {},
      cancelToken = this.cancelSource.token,
      timeout = timeoutMs
    } = {}
  ) {
    console.log(`[DELETE] Request: ${path}`)
    const headers = Object.assign(await getAuthHeader(), header)
    return await checkResponse(
      httpInstance.delete(path, {
        params: decamelizeKeys(params),
        headers,
        cancelToken,
        timeout
      }),
      errorHandlers
    )
  },
  // post put, -> (use body)
  async post (
    this: { cancelSource: CancelTokenSource },
    path: string,
    {
      body = {},
      header = {},
      errorHandlers = {},
      cancelToken = this.cancelSource.token,
      timeout = timeoutMs,
      nonGetAuthHeader = false // anonymousUserが使う
    } = {}
  ) {
    console.log(`[POST] Request: ${path}`)
    let headers = null
    if (nonGetAuthHeader) {
      headers = header
    } else {
      headers = Object.assign(await getAuthHeader(), header)
    }
    return await checkResponse(
      httpInstance.post(path, decamelizeKeys(body), {
        headers,
        cancelToken,
        timeout
      }),
      errorHandlers
    )
  },
  async put (
    this: { cancelSource: CancelTokenSource },
    path: string,
    {
      body = {},
      header = {},
      errorHandlers = {},
      cancelToken = this.cancelSource.token,
      timeout = timeoutMs
    } = {}
  ) {
    console.log(`[PUT] Request: ${path}`)
    const headers = Object.assign(await getAuthHeader(), header)
    return await checkResponse(
      httpInstance.put(path, decamelizeKeys(body), {
        headers,
        cancelToken,
        timeout
      }),
      errorHandlers
    )
  },
  // large data
  async getLargeData (path: string, args: Args = {}) {
    args.timeout = largeTimeoutMs
    return await this.get(path, args)
  },
  async deleteLargeData (path: string, args: Args = {}) {
    args.timeout = largeTimeoutMs
    return await this.delete(path, args)
  },
  // postFile , -> (use data)
  async postFile (
    this: { cancelSource: CancelTokenSource },
    path: string,
    {
      data = null,
      header = {},
      errorHandlers = {},
      cancelToken = this.cancelSource.token,
      timeout = largeTimeoutMs
    } = {}
  ) {
    console.log(`[POST] Request: ${path}`)
    const headers = Object.assign(
      { 'Content-Type': 'multipart/form-data' },
      await getAuthHeader(),
      header
    )
    return await checkResponse(
      httpInstance.post(path, data, { headers, cancelToken, timeout }),
      errorHandlers
    )
  }
}

export default apiBase

async function checkResponse (
  req: Promise<AxiosResponse>,
  errorHandlers: ErrorHandlers
): Promise<AxiosResponse> {
  return await req
    .then((res: AxiosResponse) => {
      console.log(`[Response] Status: ${res.status}`)
      if (res.status !== 204) {
        const deserialized = dataFormatter.deserialize(res.data)
        res.data = camelizeKeys(deserialized)
        console.log(res.data)
      }
      return res
    })
    .catch((error) => {
      // eslint-disable-next-line import/no-named-as-default-member
      if (axios.isCancel(error)) {
        console.log(error.message)
      } else {
        const handler = resolveErrorHandler(error, errorHandlers)
        handler(error)
      }
      throw error
    })
}

function resolveErrorHandler (
  error: Error | AxiosError,
  errorHandlers: ErrorHandlers
): (error: Error) => void {
  let errorCode = '000'
  // @ts-expect-error: check property
  const response = error.response
  if (response != null) {
    errorCode = String(response.status ?? '001')
  }
  let handler =
    errorHandlers[errorCode] != null
      ? errorHandlers[errorCode]
      : defaultErrorHandlers[errorCode]
  if (handler == null) {
    handler = () => {
      console.log(`errorCode ${errorCode} could not be handled.`)
    }
  }
  return handler
}

async function getAuthHeader (): Promise<object> {
  try {
    const token = await firebase.getIdToken()
    const cid = storage.getCid()

    return {
      Authorization: `Bearer ${token ?? ''}`,
      cid
    }
  } catch (err) {
    // TODO: サーバから拒否されることを確認するためのテスト用
    // 本来、ログイン情報なければ、下の様にサーバアクセス前にアラートあげるべき
    return {
      Authorization: 'No Token',
      cid: '0'
    }
    // alert("can't verify the login information")
    // throw err
  }
}

export const defaultErrorHandlers: ErrorHandlers = {
  '000' () {
    swal(`Network Error\n${t('apiError.networkError')}`).catch((err) =>
      console.error(err)
    )
  },
  '400' () {
    swal(`400 Bad Request\n${t('apiError.badRequest')}`).catch((err) =>
      console.error(err)
    )
  },
  '401' () {
    swal(`401 Unauthorized\n${t('apiError.unauthorized')}`).catch((err) =>
      console.error(err)
    )
  },
  '403' () {
    swal(`403 Forbidden\n${t('apiError.forbidden')}`).catch((err) =>
      console.error(err)
    )
  },
  '404' () {
    swal(`404 Not Found\n${t('apiError.notFound')}`).catch((err) =>
      console.error(err)
    )
  },
  '422' () {
    swal(
      `422 Unprocessable Entity\n${t('apiError.unprocessableEntity')}`
    ).catch((err) => console.error(err))
  },
  '500' () {
    swal(
      `500 Internal Server Error\n${t('apiError.internalServerError')}`
    ).catch((err) => console.error(err))
  },
  '503' () {
    swal(`503 Service Unavailable\n${t('apiError.serviceUnavailable')}`).catch(
      (err) => console.error(err)
    )
  }
}
