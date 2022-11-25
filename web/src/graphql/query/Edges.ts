const QUERY = /* GraphQL */ `
  query Edges($divisionId: ID!, $q: String, $offset: Int, $limit: Int) {
    edges(divisionId: $divisionId, q: $q, offset: $offset, limit: $limit) {
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
`
export default QUERY
