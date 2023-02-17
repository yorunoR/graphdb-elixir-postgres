const QUERY = /* GraphQL */ `
  query SubGraphFilterResults($subGraphFilterId: ID!) {
    subGraphFilter(subGraphFilterId: $subGraphFilterId) {
      id
      results {
        id
        name
        args
        openedAt
        divisionChangedAt
        subGraphFilterChangedAt
        props {
          key
          val
        }
        algorithm {
          name
        }
      }
    }
  }
`
export default QUERY
