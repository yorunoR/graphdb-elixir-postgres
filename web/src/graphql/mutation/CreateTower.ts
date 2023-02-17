const MUTATION = /* GraphQL */ `
  mutation CreateTower($tower: InputTower!) {
    createTower(tower: $tower) {
      id
    }
  }
`
export default MUTATION
