<template>
  <h1>Nodes</h1>
  <NodeSearchOrganism
    :division-id="divisionId"
    toggleable
    buttonLabel="Search"
    initial="[]"
    @search="search($event)"
  />
  <section class="mt-3">
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
    <ul v-else-if="data">
      <li
        v-for="node in data.nodes.entries"
        :key="node.id"
        class="list"
      >
        <NodeItemMolecule
          :node="node"
          @click:updateNode="() => emit('click:updateNode', node)"
        />
      </li>
    </ul>
    <Paginator
      :rows="variables.limit"
      :total-records="data ? data.nodes.total : 0"
      @page="onPage($event)"
    />
  </section>
</template>

<script setup lang="ts">
import { ref } from 'vue'

import { useNodesQuery } from '@/auto_generated/graphql'
import type { Node } from '@/auto_generated/graphql'
import NodeItemMolecule from '@/components/molecules/NodeItemMolecule.vue'
import NodeSearchOrganism from '@/components/organisms/NodeSearchOrganism.vue'

const props = defineProps<{
  divisionId: string;
}>()

const emit = defineEmits<{
  (e: 'click:createNode');
  (e: 'click:updateNode', node: Node);
}>()

const variables = ref({
  divisionId: props.divisionId,
  offset: 0,
  limit: 10
})

const { fetching, error, data } = useNodesQuery({
  variables,
  context: { additionalTypenames: ['Node'] }
})

const onPage = (event) => {
  variables.value.offset = event.first
}

const search = (parameters) => {
  variables.value.q = parameters
}
</script>
