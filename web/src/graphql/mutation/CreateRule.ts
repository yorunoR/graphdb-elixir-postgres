const MUTATION = /* GraphQL */ `
  mutation CreateRule($edgeTypeId: ID!, $rule: InputRule!) {
    createRule(edgeTypeId: $edgeTypeId, rule: $rule) {
      id
    }
  }
`
export default MUTATION
