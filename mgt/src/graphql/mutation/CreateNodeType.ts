const MUTATION = /* GraphQL */ `
  mutation CreateNodeType($divisionId: ID!, $nodeType: InputNodeType!) {
    createNodeType(divisionId: $divisionId, nodeType: $nodeType) {
      id
    }
  }
`
export default MUTATION
