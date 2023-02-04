const QUERY = /* GraphQL */ `
  query LibgraphStatus($subGraphFilterId: ID!) {
    libgraphStatus(subGraphFilterId: $subGraphFilterId) {
      status
      openedAt
      divisionChangedAt
      subGraphFilterChangedAt
      currentDivisionChangedAt
      currentSubGraphFilterChangedAt
      commands {
        id
        name
        arity
        description
      }
    }
  }
`
export default QUERY
