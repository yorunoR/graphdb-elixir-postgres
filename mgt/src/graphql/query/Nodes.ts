const QUERY = /* GraphQL */ `
  query Nodes($divisionId: ID!, $q: String, $offset: Int, $limit: Int) {
    nodes(divisionId: $divisionId, q: $q, offset: $offset, limit: $limit) {
      entries {
        id
        name
        uid
        nodeTypeId
        props {
          key
          val
        }
        nodeType {
          id
          name
        }
      }
      limit
      offset
      total
    }
  }
`
export default QUERY
