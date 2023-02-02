const QUERY = /* GraphQL */ `
  query SubGraphStatus($subGraphFilterId: ID!) {
    subGraphStatus(subGraphFilterId: $subGraphFilterId) {
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
