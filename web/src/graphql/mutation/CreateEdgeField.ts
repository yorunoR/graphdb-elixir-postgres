const MUTATION = /* GraphQL */ `
  mutation CreateEdgeField($edgeTypeId: ID!, $edgeField: InputEdgeField!) {
    createEdgeField(edgeTypeId: $edgeTypeId, edgeField: $edgeField) {
      id
    }
  }
`
export default MUTATION
