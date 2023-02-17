const MUTATION = /* GraphQL */ `
  mutation UpdateEdgeType($edgeTypeId: ID!, $edgeType: InputEdgeType!) {
    updateEdgeType(edgeTypeId: $edgeTypeId, edgeType: $edgeType) {
      id
    }
  }
`
export default MUTATION
