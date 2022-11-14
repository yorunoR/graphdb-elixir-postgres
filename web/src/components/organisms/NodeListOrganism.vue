<template>
  <h1>Nodes</h1>
  <section>
    <Button
      class="w-full"
      label="Create"
      @click="() => emit('click:createNode')"
    />
  </section>
  <section>
    <div
      v-if="fetching"
      class="mt-4"
    >
      Loading...
    </div>
    <div
      v-else-if="error"
      class="mt-4"
    >
      Oh no... {{ error }}
    </div>
    <ul v-else-if="data && data.division">
      <li
        v-for="node in data.division.nodes.entries"
        :key="node.id"
      >
        <NodeItemMolecule
          :node="node"
          @click:updateNode="() => emit('click:updateNode', node)"
        />
      </li>
    </ul>
    <Paginator
      :rows="limit"
      :total-records="data && data.division ? data.division.nodes.total : 0"
      @page="onPage($event)"
    />
  </section>
</template>

<script setup lang="ts">
import { ref } from 'vue'

import { useDivisionNodesQuery } from '@/auto_generated/graphql'
import type { Node } from '@/auto_generated/graphql'
import NodeItemMolecule from '@/components/molecules/NodeItemMolecule.vue'

const props = defineProps<{
  divisionId: string;
}>()

const emit = defineEmits<{
  (e: 'click:createNode');
  (e: 'click:updateNode', node: Node);
}>()

const offset = ref(0)
const limit = ref(10)

const { fetching, error, data, executeQuery } = useDivisionNodesQuery({
  variables: { divisionId: props.divisionId, offset, limit },
  context: { additionalTypenames: ['Node'] }
})

const onPage = (event) => {
  offset.value = event.first
  executeQuery()
}
</script>
