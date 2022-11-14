import type { UseQueryResponse, AnyVariables } from '@urql/vue'

import {
  useDivisionSummaryQuery,
  useDivisionNodeTypesQuery,
  useDivisionEdgeTypesQuery
} from '@/auto_generated/graphql'
import type {
  DivisionSummaryQuery,
  DivisionNodeTypesQuery,
  DivisionEdgeTypesQuery
} from '@/auto_generated/graphql'

export const callDivisionNodeTypesQuery = (
  divisionId: string
): UseQueryResponse<DivisionNodeTypesQuery, AnyVariables> => {
  return useDivisionNodeTypesQuery({
    variables: { divisionId },
    context: { additionalTypenames: ['NodeType', 'NodeField'] }
  })
}

export const callDivisionEdgeTypesQuery = (
  divisionId: string
): UseQueryResponse<DivisionEdgeTypesQuery, AnyVariables> => {
  return useDivisionEdgeTypesQuery({
    variables: { divisionId },
    context: { additionalTypenames: ['EdgeType', 'EdgeField', 'Rule'] }
  })
}

export const callDivisionSummaryQuery = (
  divisionId: string
): UseQueryResponse<DivisionSummaryQuery, AnyVariables> => {
  return useDivisionSummaryQuery({
    variables: {
      divisionId,
      selections: [
        'nodeTypeCount',
        'edgeTypeCount',
        'nodeCount',
        'edgeCount'
      ]
    },
    context: { additionalTypenames: ['NodeType', 'Node', 'EdgeType', 'Edge'] }
  })
}
