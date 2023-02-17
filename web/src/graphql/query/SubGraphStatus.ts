const QUERY = /* GraphQL */ `
  query SubGraphStatus($subGraphFilterId: ID!) {
    subGraphStatus(subGraphFilterId: $subGraphFilterId) {
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
