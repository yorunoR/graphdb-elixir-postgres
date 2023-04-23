const QUERY = /* GraphQL */ `
  query NodeBoundEdges($divisionId: ID!, $q: String, $qNode: String, $offset: Int, $limit: Int) {
    nodeBoundEdges(divisionId: $divisionId, q: $q, qNode: $qNode, offset: $offset, limit: $limit) {
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
