const MUTATION = /* GraphQL */ `
  mutation UpdateNode($nodeId: ID!, $node: InputNode!) {
    updateNode(nodeId: $nodeId, node: $node) {
      id
    }
  }
`
export default MUTATION
