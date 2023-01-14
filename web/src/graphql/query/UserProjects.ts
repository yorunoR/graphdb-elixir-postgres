const QUERY = /* GraphQL */ `
  query UserProjects {
    currentUser {
      id
      projects {
        id
        name
        projectKey
        default
      }
    }
  }
`
export default QUERY
