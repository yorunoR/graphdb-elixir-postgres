<template>
  <h1>Edges</h1>
  <section>
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
    <ul v-else-if="data && data.division">
      <li
        v-for="edge in data.division.edges.entries"
        :key="edge.id"
      >
        <EdgeItemMolecule
          :edge="edge"
          @click:updateEdge="() => emit('click:updateEdge', edge)"
        />
      </li>
    </ul>
    <Paginator
      :rows="limit"
      :total-records="data && data.division ? data.division.edges.total : 0"
      @page="onPage($event)"
    />
  </section>
</template>

<script setup lang="ts">
import { ref } from 'vue'

import { useDivisionEdgesQuery } from '@/auto_generated/graphql'
import type { Edge } from '@/auto_generated/graphql'
import EdgeItemMolecule from '@/components/molecules/EdgeItemMolecule.vue'

const props = defineProps<{
  divisionId: string;
}>()

const emit = defineEmits<{
  (e: 'click:createEdge');
  (e: 'click:updateEdge', edge: Edge);
}>()

const offset = ref(0)
const limit = ref(10)

const { fetching, error, data } = useDivisionEdgesQuery({
  variables: { divisionId: props.divisionId, offset, limit },
  context: { additionalTypenames: ['Edge'] }
})
</script>
