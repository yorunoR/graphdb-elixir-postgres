import type { Item } from '@/auto_generated/graphql'

interface ResourceObject {
  __typename: string
  id: string
}

interface StringKeyObject {
  [key: string]: string
}

export const objId = (obj: ResourceObject): string => {
  return `${obj.__typename}_${obj.id}`
}

export const listToMap = (list: [Item] | undefined): StringKeyObject => {
  if (list == null) return {}

  return list.reduce((map: StringKeyObject, item) => {
    map[item.key] = item.val
    return map
  }, {})
}

export const mapToList = (map: StringKeyObject): Item[] => {
  return Object.entries(map).map(([key, val]) => ({ key, val }))
}
