const QUERY = /* GraphQL */ `
  query DivisionSummary($divisionId: ID!, $selections: [String!]!) {
    division(divisionId: $divisionId) {
      id
      name
      project {
        id
        name
        default
      }
      tower {
        id
        name
      }
      summary(selections: $selections) {
        key
        val
      }
    }
  }
`
export default QUERY
