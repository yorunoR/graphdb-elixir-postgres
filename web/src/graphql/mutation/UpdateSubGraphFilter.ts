const MUTATION = /* GraphQL */ `
  mutation UpdateSubGraphFilter(
    $subGraphFilterId: ID!
    $subGraphFilter: InputSubGraphFilter!
  ) {
    updateSubGraphFilter(
      subGraphFilterId: $subGraphFilterId
      subGraphFilter: $subGraphFilter
    ) {
      id
    }
  }
`
export default MUTATION
