const QUERY = /* GraphQL */ `
  query SubGraphCommand($subGraphFilterId: ID!, $command: String!, $opts: [String]) {
    subGraphCommand(subGraphFilterId: $subGraphFilterId, command: $command, opts: $opts) {
      props {
        key
        val
      }
    }
  }
`
export default QUERY
