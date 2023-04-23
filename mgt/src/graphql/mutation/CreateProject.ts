const MUTATION = /* GraphQL */ `
  mutation CreateProject($project: InputProject!) {
    createProject(project: $project) {
      id
    }
  }
`
export default MUTATION
