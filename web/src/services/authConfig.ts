import { makeOperation } from '@urql/core'
import type { AuthConfig } from '@urql/exchange-auth'

import firebase from '@/services/firebase'
import storage from '@/services/storage'

interface AuthState {
  token: string | null
  cid: string | null
}

export const authConfig: AuthConfig<AuthState> = {
  getAuth: async () => {
    const token = await firebase.getIdToken()
    const cid = storage.getCid()
    return { token, cid }
  },
  willAuthError: () => {
    return true
  },
  addAuthToOperation: ({ authState, operation }) => {
    if (authState == null || authState.token == null || authState.cid == null) {
      return operation
    }

    // prettier-ignore
    const fetchOptions: RequestInit =
      (typeof operation.context.fetchOptions) === 'function'
        // @ts-expect-error: It is always callable
        ? operation.context.fetchOptions?.()
        : operation.context.fetchOptions != null || {}

    return makeOperation(operation.kind, operation, {
      ...operation.context,
      fetchOptions: {
        ...fetchOptions,
        headers: {
          ...fetchOptions.headers,
          Authorization: 'Bearer ' + authState.token,
          cid: authState.cid
        }
      }
    })
  }
}
