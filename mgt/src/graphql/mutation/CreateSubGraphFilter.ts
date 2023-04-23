const MUTATION = /* GraphQL */ `
  mutation CreateSubGraphFilter(
    $divisionId: ID!
    $subGraphFilter: InputSubGraphFilter!
  ) {
    createSubGraphFilter(
      divisionId: $divisionId
      subGraphFilter: $subGraphFilter
    ) {
      id
    }
  }
`
export default MUTATION
