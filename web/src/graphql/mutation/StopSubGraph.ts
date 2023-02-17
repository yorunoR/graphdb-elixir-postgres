const MUTATION = /* GraphQL */ `
  mutation StopSubGraph($subGraphFilterId: ID!) {
    stopSubGraph(subGraphFilterId: $subGraphFilterId) {
      status
    }
  }
`
export default MUTATION
