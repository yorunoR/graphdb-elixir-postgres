const MUTATION = /* GraphQL */ `
  mutation UpdateSubGraphFilter(
    $subGraphFilterId: ID!
    $subGraphFilter: InputSubGraphFilter
    $qNode: String
    $qEdge: String
  ) {
    updateSubGraphFilter(
      subGraphFilterId: $subGraphFilterId
      subGraphFilter: $subGraphFilter
      qNode: $qNode
      qEdge: $qEdge
    ) {
      id
    }
  }
`
export default MUTATION
