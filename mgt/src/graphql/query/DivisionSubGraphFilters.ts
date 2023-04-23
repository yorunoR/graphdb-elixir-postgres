const QUERY = /* GraphQL */ `
  query DivisionSubGraphFilters($divisionId: ID!) {
    division(divisionId: $divisionId) {
      id
      name
      subGraphFilters {
        id
        name
        uid
      }
    }
  }
`
export default QUERY
