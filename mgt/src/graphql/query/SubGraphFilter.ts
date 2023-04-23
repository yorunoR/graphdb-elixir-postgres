const QUERY = /* GraphQL */ `
  query SubGraphFilter($subGraphFilterId: ID!) {
    subGraphFilter(subGraphFilterId: $subGraphFilterId) {
      id
      name
      uid
      nodeFilter
      edgeFilter
      division {
        id
        name
      }
      tower {
        id
        name
      }
      project {
        id
        name
        default
      }
    }
  }
`
export default QUERY
