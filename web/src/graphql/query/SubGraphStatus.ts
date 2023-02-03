const QUERY = /* GraphQL */ `
  query SubGraphStatus($subGraphFilterId: ID!) {
    subGraphStatus(subGraphFilterId: $subGraphFilterId) {
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
