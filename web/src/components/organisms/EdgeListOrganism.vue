<template>
  <h1>Edges</h1>
  <EdgeSearchOrganism
    :division-id="divisionId"
    @search="search($event)"
  />
  <section class="mt-3">
    <Button
      class="w-full"
      label="Create"
      @click="() => emit('click:createEdge')"
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
        v-for="edge in data.edges.entries"
        :key="edge.id"
        class="list"
      >
        <EdgeItemMolecule
          :edge="edge"
          @click:updateEdge="() => emit('click:updateEdge', edge)"
        />
      </li>
    </ul>
    <Paginator
      :rows="variables.limit"
      :total-records="data ? data.edges.total : 0"
      @page="onPage($event)"
    />
  </section>
</template>

<script setup lang="ts">
import { ref } from 'vue'

import { useEdgesQuery } from '@/auto_generated/graphql'
import type { Edge } from '@/auto_generated/graphql'
import EdgeItemMolecule from '@/components/molecules/EdgeItemMolecule.vue'
import EdgeSearchOrganism from '@/components/organisms/EdgeSearchOrganism.vue'

const props = defineProps<{
  divisionId: string;
}>()

const emit = defineEmits<{
  (e: 'click:createEdge');
  (e: 'click:updateEdge', edge: Edge);
}>()

const variables = ref({
  divisionId: props.divisionId,
  offset: 0,
  limit: 10
})

const { fetching, error, data } = useEdgesQuery({
  variables,
  context: { additionalTypenames: ['Edge'] }
})

const onPage = (event) => {
  variables.value.offset = event.first
}

const search = (parameters) => {
  variables.value.q = parameters
}
</script>
