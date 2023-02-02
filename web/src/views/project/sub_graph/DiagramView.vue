<template>
  <main style="max-width: 768px; margin: auto">
    <h1>Diagram</h1>
    <section>
      <div
        ref="root"
        class="diagram"
      />
    </section>
  </main>
</template>

<script setup lang="ts">
import { DataSet, Network } from 'vis-network/standalone'
import { ref, onMounted } from 'vue'

const props = defineProps<{
  divisionId: string;
  subGraphFilterId: string;
}>()

const root = ref(null)

const nodes = new DataSet([
  { id: 1, label: 'Node 1' },
  { id: 2, label: 'Node 2' },
  { id: 3, label: 'Node 3' },
  { id: 4, label: 'Node 4' },
  { id: 5, label: 'Node 5' }
])

const edges = new DataSet([
  { from: 1, to: 3 },
  { from: 1, to: 2 },
  { from: 2, to: 4 },
  { from: 2, to: 5 },
  { from: 3, to: 3 }
])

const data = {
  nodes,
  edges
}

onMounted(() => {
  const options = {}
  const _network = new Network(root.value, data, options)
})
</script>

<style lang="scss">
  .diagram {
    height: calc(100vh - 180px);
    border: 1px solid lightgray;
  }
</style>
