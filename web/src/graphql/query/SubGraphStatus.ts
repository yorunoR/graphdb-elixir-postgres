const QUERY = /* GraphQL */ `
  query SubGraphStatus($subGraphFilterId: ID!) {
    subGraphStatus(subGraphFilterId: $subGraphFilterId) {
      status
      nodes
      edges
      openedAt
    }
  }
`
export default QUERY
