const QUERY = /* GraphQL */ `
  query SubGraphData($subGraphFilterId: ID!) {
    subGraphData(subGraphFilterId: $subGraphFilterId) {
      nodes {
        id
        uid
        name
        props {
          key
          val
        }
        nodeTypeId
        nodeType {
          name
        }
      }
      edges {
        id
        name
        props {
          key
          val
        }
        edgeTypeId
        edgeType {
          name
        }
        endNodeId
        endNode {
          name
        }
        startNodeId
        startNode {
          name
        }
      }
    }
  }
`
export default QUERY
