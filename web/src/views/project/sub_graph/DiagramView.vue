<template>
  <main style="max-width: 768px; margin: auto">
    <h1>Diagram</h1>
    <VisDiagramMolecule
      v-if="data"
      :key="resetKey"
      :subGraphData="data.subGraphData"
      :results="resultsData ? resultsData.subGraphFilter.results : []"
      @reset="() => reset()"
    />
  </main>
</template>

<script setup lang="ts">
import { ref } from 'vue'

import { useSubGraphDataQuery, useSubGraphFilterResultsQuery } from '@/auto_generated/graphql'
import VisDiagramMolecule from '@/components/molecules/VisDiagramMolecule.vue'

const props = defineProps<{
  divisionId: string;
  subGraphFilterId: string;
}>()

const resetKey = ref(0)

const { data } = useSubGraphDataQuery({
  variables: { subGraphFilterId: props.subGraphFilterId },
  context: { additionalTypenames: ['SubGraphFilter'] }
})

const { data: resultsData } = useSubGraphFilterResultsQuery({
  variables: { subGraphFilterId: props.subGraphFilterId },
  context: { additionalTypenames: ['Result'] }
})

const reset = () => {
  resetKey.value++
}
</script>
