const QUERY = /* GraphQL */ `
  query DivisionNodes($divisionId: ID!, $offset: Int, $limit: Int) {
    division(divisionId: $divisionId) {
      id
      name
      nodes(offset: $offset, limit: $limit) {
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
  }
`
export default QUERY
