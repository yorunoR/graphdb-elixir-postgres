const QUERY = /* GraphQL */ `
  query DivisionEdges($divisionId: ID!, $offset: Int, $limit: Int) {
    division(divisionId: $divisionId) {
      id
      name
      edges(offset: $offset, limit: $limit) {
        entries {
          id
          name
          edgeTypeId
          props {
            key
            val
          }
          edgeType {
            id
            name
            uid
          }
          startNode {
            id
            name
            uid
          }
          endNode {
            id
            name
            uid
          }
        }
        limit
        offset
        total
      }
    }
  }
`
export default QUERY
