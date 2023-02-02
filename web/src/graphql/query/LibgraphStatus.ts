const QUERY = /* GraphQL */ `
  query LibgraphStatus($subGraphFilterId: ID!) {
    libgraphStatus(subGraphFilterId: $subGraphFilterId) {
      status
      openedAt
      commands {
        name
        arity
        description
      }
    }
  }
`
export default QUERY
