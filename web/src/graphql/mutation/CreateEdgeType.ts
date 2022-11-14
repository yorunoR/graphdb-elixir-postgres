const MUTATION = /* GraphQL */ `
  mutation CreateEdgeType($divisionId: ID!, $edgeType: InputEdgeType!) {
    createEdgeType(divisionId: $divisionId, edgeType: $edgeType) {
      id
    }
  }
`
export default MUTATION
