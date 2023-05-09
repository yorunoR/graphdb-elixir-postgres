<template>
  <section>
    <div
      ref="root"
      class="diagram"
    />
    <div class="flex flex-row mt-4">
      <Button
        class="mr-2 flex-grow-1"
        :label="$t('common.highlight')"
        @click="() => highlight()"
      />
      <Button
        class="p-button-outlined ml-2 flex-grow-1"
        :label="$t('common.reset')"
        @click="() => emit('reset')"
      />
    </div>
  </section>
  <Sidebar
    v-model:visible="visibleRight"
    position="right"
    :modal="false"
  >
    <strong>{{ $t('subGraph.results') }}</strong>
    <div
      v-for="result in results"
      :key="objId(result.id)"
      class="mt-4"
    >
      <RadioButton
        v-model="resultId"
        :input-id="`result-${result.id}`"
        name="resultId"
        :value="result.id"
      />
      <label
        :for="`result-${result.id}`"
        class="ml-2 cursor-pointer"
      >
        <span>{{ result.name }}</span>
        <div class="text-right">{{ result.algorithm.name }}{{ result.args }}</div>
      </label>
    </div>
    <Button
      class="w-full mt-4"
      :label="$t('common.apply')"
      @click="() => apply()"
    />
  </Sidebar>
</template>

<script setup lang="ts">
import type { Result, SubGraphData } from '@auto_generated/graphql'
import { DataSet, Network } from 'vis-network/standalone'
import { ref, onMounted } from 'vue'

import { objId } from '@/services/utils'

const props = defineProps<{
  subGraphData: SubGraphData;
  results: [Result];
}>()

const emit = defineEmits<{
  (e: 'reset'): void;
}>()

const root = ref(null)
const visibleRight = ref(false)
const resultId = ref(null)

const nodeRecords = props.subGraphData.nodes.map(node => {
  return { id: node.id, label: node.name }
})

const edgeRecords = props.subGraphData.edges.map(edge => {
  return { id: edge.id, from: edge.startNodeId, to: edge.endNodeId }
})

const nodes = new DataSet(nodeRecords)
const edges = new DataSet(edgeRecords)

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

onMounted(() => {
  const _network = new Network(root.value, { nodes, edges }, options)
})

const highlight = () => {
  visibleRight.value = true
}

const apply = () => {
  const targetResult = props.results.find(result => result.id === resultId.value)

  targetResult.props.forEach((_, index) => {
    if (!index) return

    const from = targetResult.props[index - 1].val
    const to = targetResult.props[index].val

    const targetEdge = edgeRecords.find(edgeRecord => edgeRecord.from === from && edgeRecord.to === to)
    edges.updateOnly({ id: targetEdge.id, width: 8 })
  })

  visibleRight.value = false
}
</script>

<style lang="scss">
  .diagram {
    height: calc(100vh - 360px);
    border: 1px solid lightgray;
  }
</style>
