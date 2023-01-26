const QUERY = /* GraphQL */ `
  query LibgraphStatus($subGraphFilterId: ID!) {
    libgraphStatus(subGraphFilterId: $subGraphFilterId) {
      status
      openedAt
    }
  }
`
export default QUERY
