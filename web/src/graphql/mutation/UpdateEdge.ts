const MUTATION = /* GraphQL */ `
  mutation UpdateEdge($edgeId: ID!, $edge: InputEdge!) {
    updateEdge(edgeId: $edgeId, edge: $edge) {
      id
    }
  }
`
export default MUTATION
