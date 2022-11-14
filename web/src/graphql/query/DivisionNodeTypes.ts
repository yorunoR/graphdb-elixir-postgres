const QUERY = /* GraphQL */ `
  query DivisionNodeTypes($divisionId: ID!) {
    division(divisionId: $divisionId) {
      id
      name
      nodeTypes {
        id
        name
        uid
        nodeFields {
          id
          name
          type
          uid
        }
      }
    }
  }
`
export default QUERY
