const QUERY = /* GraphQL */ `
  query ProjectTowers {
    currentProject {
      id
      name
      towers {
        id
        name
      }
    }
  }
`
export default QUERY
