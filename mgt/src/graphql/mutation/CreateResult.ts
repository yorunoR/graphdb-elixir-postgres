const MUTATION = /* GraphQL */ `
  mutation CreateResult($subGraphFilterId: ID!, $agency: String!, $command: String! $result: InputResult!) {
    createResult(subGraphFilterId: $subGraphFilterId, agency: $agency, command: $command, result: $result) {
      id
    }
  }
`
export default MUTATION
