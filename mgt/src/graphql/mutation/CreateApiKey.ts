const MUTATION = /* GraphQL */ `
  mutation CreateApiKey($apiKey: InputApiKey!) {
    createApiKey(apiKey: $apiKey) {
      id
    }
  }
`
export default MUTATION
