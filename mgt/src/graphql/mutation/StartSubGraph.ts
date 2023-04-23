const MUTATION = /* GraphQL */ `
  mutation StartSubGraph($subGraphFilterId: ID!) {
    startSubGraph(subGraphFilterId: $subGraphFilterId) {
      status
    }
  }
`
export default MUTATION
