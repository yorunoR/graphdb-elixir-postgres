const MUTATION = /* GraphQL */ `
  mutation StartLibgraph($subGraphFilterId: ID!) {
    startLibgraph(subGraphFilterId: $subGraphFilterId) {
      status
    }
  }
`
export default MUTATION
