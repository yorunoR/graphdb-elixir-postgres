const MUTATION = /* GraphQL */ `
  mutation CreateEdge($edge: InputEdge!) {
    createEdge(edge: $edge) {
      id
    }
  }
`
export default MUTATION
