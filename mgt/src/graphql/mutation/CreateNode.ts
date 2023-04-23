const MUTATION = /* GraphQL */ `
  mutation CreateNode($node: InputNode!) {
    createNode(node: $node) {
      id
    }
  }
`
export default MUTATION
