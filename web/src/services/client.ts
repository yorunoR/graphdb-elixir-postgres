// import { authExchange } from "@urql/exchange-auth";
import {
  createClient,
  dedupExchange,
  cacheExchange,
  fetchExchange
  // subscriptionExchange
} from '@urql/vue'
// import { absintheConfig } from "@/services/absintheConfig";
// import { authConfig } from "@/services/authConfig";
import type { Client } from '@urql/vue'

const API_URL = process.env.VUE_APP_API_URL as string

export function makeClient (): Client {
  return createClient({
    url: `${API_URL}/api`,
    exchanges: [
      dedupExchange,
      cacheExchange,
      // authExchange(authConfig),
      fetchExchange
      // subscriptionExchange(absintheConfig),
    ]
  })
}
