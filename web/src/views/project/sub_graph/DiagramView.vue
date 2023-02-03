<template>
  <main style="max-width: 768px; margin: auto">
    <h1>Diagram</h1>
    <VisDiagramMolecule
      v-if="data"
      :subGraphData="data.subGraphData"
    />
  </main>
</template>

<script setup lang="ts">
import { useSubGraphDataQuery } from '@/auto_generated/graphql'
import VisDiagramMolecule from '@/components/molecules/VisDiagramMolecule.vue'

const props = defineProps<{
  divisionId: string;
  subGraphFilterId: string;
}>()

const { data } = useSubGraphDataQuery({
  variables: { subGraphFilterId: props.subGraphFilterId },
  context: { additionalTypenames: ['SubGraphFilter'] }
})
</script>
