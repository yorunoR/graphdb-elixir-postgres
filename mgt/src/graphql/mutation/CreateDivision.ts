const MUTATION = /* GraphQL */ `
  mutation CreateDivision($towerId: ID!, $division: InputDivision!) {
    createDivision(towerId: $towerId, division: $division) {
      id
    }
  }
`
export default MUTATION
