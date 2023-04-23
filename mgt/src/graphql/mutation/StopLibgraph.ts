const MUTATION = /* GraphQL */ `
  mutation StopLibgraph($subGraphFilterId: ID!) {
    stopLibgraph(subGraphFilterId: $subGraphFilterId) {
      status
    }
  }
`
export default MUTATION
