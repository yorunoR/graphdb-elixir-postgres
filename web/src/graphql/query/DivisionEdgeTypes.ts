const QUERY = /* GraphQL */ `
  query DivisionEdgeTypes($divisionId: ID!) {
    division(divisionId: $divisionId) {
      id
      name
      edgeTypes {
        id
        name
        uid
        edgeFields {
          id
          name
          type
          uid
        }
        rules {
          id
          name
          startNodeType {
            id
            name
          }
          endNodeType {
            id
            name
          }
        }
      }
    }
  }
`
export default QUERY
