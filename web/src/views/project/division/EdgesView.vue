<template>
  <main style="max-width: 768px; margin: auto">
    <EdgeListOrganism
      :division-id="divisionId"
      @click:createEdge="() => (visibleRight = true)"
      @click:updateEdge="(edge) => openUpdateEdge(edge)"
    />
  </main>
  <Sidebar
    v-model:visible="visibleRight"
    position="right"
  >
    <EdgeCreateOrganism
      :division-id="divisionId"
      @created="visibleRight = false"
    />
  </Sidebar>
  <Sidebar
    v-model:visible="visibleRight2"
    position="right"
  >
    <EdgeUpdateOrganism
      :division-id="divisionId"
      :edge="selectedEdge"
      @updated="visibleRight2 = false"
    />
  </Sidebar>
</template>

<script setup lang="ts">
import { ref } from 'vue'

import EdgeCreateOrganism from '@/components/organisms/EdgeCreateOrganism.vue'
import EdgeListOrganism from '@/components/organisms/EdgeListOrganism.vue'
import EdgeUpdateOrganism from '@/components/organisms/EdgeUpdateOrganism.vue'

defineProps<{
  divisionId: string;
}>()

const visibleRight = ref(false)
const visibleRight2 = ref(false)
const selectedEdge = ref({})

const openUpdateEdge = (edge) => {
  selectedEdge.value = edge
  visibleRight2.value = true
}
</script>
