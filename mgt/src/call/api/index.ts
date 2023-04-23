import type { CancelToken, AxiosResponse } from 'axios'

import ApiBase from '@/services/apiBase'

interface UploadArgs {
  nodeTypeId?: string
  edgeTypeId?: string
  errorHandlers?: object
  header?: object
  body?: object
  timeout?: number
  cancelToken?: CancelToken
  nonGetAuthHeader?: boolean
}

export const uploadNodes = async (args: UploadArgs): Promise<AxiosResponse> => {
  const { nodeTypeId } = args
  if (nodeTypeId == null) throw new Error('Missing parameters')
  return await ApiBase.postFile(`/upload/nodes/${nodeTypeId}`, args)
}

export const uploadEdges = async (args: UploadArgs): Promise<AxiosResponse> => {
  const { edgeTypeId } = args
  if (edgeTypeId == null) throw new Error('Missing parameters')
  return await ApiBase.postFile(`/upload/edges/${edgeTypeId}`, args)
}
