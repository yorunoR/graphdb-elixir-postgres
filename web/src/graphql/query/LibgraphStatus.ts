const QUERY = /* GraphQL */ `
  query LibgraphStatus($subGraphFilterId: ID!) {
    libgraphStatus(subGraphFilterId: $subGraphFilterId) {
      status
      openedAt
      updatedAt
      commands {
        name
        arity
        description
      }
    }
  }
`
export default QUERY
