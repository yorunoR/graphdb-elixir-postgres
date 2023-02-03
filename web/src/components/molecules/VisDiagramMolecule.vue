<template>
  <section>
    <div
      ref="root"
      class="diagram"
    />
  </section>
</template>

<script setup lang="ts">
import type { SubGraphData } from '@auto_generated/graphql'
import { DataSet, Network } from 'vis-network/standalone'
import { ref, onMounted } from 'vue'

const props = defineProps<{
  subGraphData: SubGraphData;
}>()

const root = ref(null)

const nodeRecords = props.subGraphData.nodes.map(node => {
  return { id: node.id, label: node.name }
})

const edgeRecords = props.subGraphData.edges.map(edge => {
  return { from: edge.startNodeId, to: edge.endNodeId }
})

const nodes = new DataSet(nodeRecords)
const edges = new DataSet(edgeRecords)

onMounted(() => {
  const options = {
    edges: { arrows: { to: { enabled: true } } },
    physics: {
      forceAtlas2Based: {
        gravitationalConstant: -126,
        springLength: 200,
        springConstant: 0.01
      },
      maxVelocity: 50,
      minVelocity: 10,
      solver: 'forceAtlas2Based',
      timestep: 0.35,
      stabilization: true
    }
  }
  const _network = new Network(root.value, { nodes, edges }, options)
})
</script>

<style lang="scss">
  .diagram {
    height: calc(100vh - 180px);
    border: 1px solid lightgray;
  }
</style>
