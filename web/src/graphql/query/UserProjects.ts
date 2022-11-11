const QUERY = /* GraphQL */ `
  query UserProjects {
    currentUser {
      id
      projects {
        id
        name
        default
      }
    }
  }
`
export default QUERY
