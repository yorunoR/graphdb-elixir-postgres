const QUERY = /* GraphQL */ `
  query LibgraphCommand($subGraphFilterId: ID!, $command: String!, $opts: [String]) {
    libgraphCommand(subGraphFilterId: $subGraphFilterId, command: $command, opts: $opts) {
      props {
        key
        val
      }
    }
  }
`
export default QUERY
