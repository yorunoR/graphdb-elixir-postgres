const QUERY = /* GraphQL */ `
  query TowerDivisions($towerId: ID!, $offset: Int, $limit: Int) {
    tower(towerId: $towerId) {
      id
      name
      divisions(offset: $offset, limit: $limit) {
        entries {
          id
          name
          divisionHash
        }
        offset
        limit
        total
      }
      project {
        id
        name
        default
      }
    }
  }
`
export default QUERY
