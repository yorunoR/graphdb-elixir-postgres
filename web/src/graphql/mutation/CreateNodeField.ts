const MUTATION = /* GraphQL */ `
  mutation CreateNodeField($nodeTypeId: ID!, $nodeField: InputNodeField!) {
    createNodeField(nodeTypeId: $nodeTypeId, nodeField: $nodeField) {
      id
    }
  }
`
export default MUTATION
