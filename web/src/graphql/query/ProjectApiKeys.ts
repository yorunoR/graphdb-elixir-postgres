const QUERY = /* GraphQL */ `
  query ProjectApiKeys {
    currentProject {
      id
      name
      apiKeys {
        id
        name
        shortToken
      }
    }
  }
`
export default QUERY
