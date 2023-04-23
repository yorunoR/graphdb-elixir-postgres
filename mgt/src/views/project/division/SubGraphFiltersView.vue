<template>
  <main style="max-width: 768px; margin: auto">
    <SubGraphFilterListOrganism
      :division-id="divisionId"
      @click:createSubGraphFilter="() => (visibleRight = true)"
      @click:updateSubGraphFilter="
        (subGraphFilter) => openUpdateSubGraphFilter(subGraphFilter)
      "
    />
  </main>
  <Sidebar
    v-model:visible="visibleRight"
    position="right"
  >
    <SubGraphFilterCreateOrganism
      :division-id="divisionId"
      @created="visibleRight = false"
    />
  </Sidebar>
  <Sidebar
    v-model:visible="visibleRight2"
    position="right"
  >
    <SubGraphFilterUpdateOrganism
      :sub-graph-filter="selectedSubGraphFilter"
      @created="visibleRight2 = false"
    />
  </Sidebar>
</template>

<script setup lang="ts">
import { ref } from 'vue'

import SubGraphFilterCreateOrganism from '@/components/organisms/SubGraphFilterCreateOrganism.vue'
import SubGraphFilterListOrganism from '@/components/organisms/SubGraphFilterListOrganism.vue'
import SubGraphFilterUpdateOrganism from '@/components/organisms/SubGraphFilterUpdateOrganism.vue'

defineProps<{
  divisionId: string;
}>()

const visibleRight = ref(false)
const visibleRight2 = ref(false)
const selectedSubGraphFilter = ref({})

const openUpdateSubGraphFilter = (subGraphFilter) => {
  selectedSubGraphFilter.value = subGraphFilter
  visibleRight2.value = true
}
</script>
