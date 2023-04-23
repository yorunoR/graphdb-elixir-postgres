const MUTATION = /* GraphQL */ `
  mutation UpdateNodeType($nodeTypeId: ID!, $nodeType: InputNodeType!) {
    updateNodeType(nodeTypeId: $nodeTypeId, nodeType: $nodeType) {
      id
    }
  }
`
export default MUTATION
