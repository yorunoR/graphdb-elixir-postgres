<template>
  <main style="max-width: 768px; margin: auto">
    <EdgeTypeListOrganism
      :division-id="divisionId"
      @click:createEdgeType="() => (visibleRight = true)"
      @click:updateEdgeType="(edgeType) => openUpdateEdgeType(edgeType)"
      @click:createEdgeField="(edgeType) => openCreateEdgeField(edgeType)"
      @click:createRule="(edgeType) => openCreateRule(edgeType)"
    />
  </main>
  <Sidebar
    v-model:visible="visibleRight"
    position="right"
  >
    <EdgeTypeCreateOrganism
      :division-id="divisionId"
      @created="visibleRight = false"
    />
  </Sidebar>
  <Sidebar
    v-model:visible="visibleRight2"
    position="right"
  >
    <EdgeTypeUpdateOrganism
      :edge-type="selectedEdgeType"
      @created="visibleRight2 = false"
    />
  </Sidebar>
  <Sidebar
    v-model:visible="visibleRight3"
    position="right"
  >
    <EdgeFieldCreateOrganism
      :edge-type="selectedEdgeType"
      @created="visibleRight3 = false"
    />
  </Sidebar>
  <Sidebar
    v-model:visible="visibleRight4"
    position="right"
  >
    <RuleCreateOrganism
      :division-id="divisionId"
      :edge-type="selectedEdgeType"
      @created="visibleRight4 = false"
    />
  </Sidebar>
</template>

<script setup lang="ts">
import { ref } from 'vue'

import EdgeFieldCreateOrganism from '@/components/organisms/EdgeFieldCreateOrganism.vue'
import EdgeTypeCreateOrganism from '@/components/organisms/EdgeTypeCreateOrganism.vue'
import EdgeTypeListOrganism from '@/components/organisms/EdgeTypeListOrganism.vue'
import EdgeTypeUpdateOrganism from '@/components/organisms/EdgeTypeUpdateOrganism.vue'
import RuleCreateOrganism from '@/components/organisms/RuleCreateOrganism.vue'

defineProps<{
  divisionId: string;
}>()

const visibleRight = ref(false)
const visibleRight2 = ref(false)
const visibleRight3 = ref(false)
const visibleRight4 = ref(false)
const selectedEdgeType = ref({})

const openUpdateEdgeType = (edgeType) => {
  selectedEdgeType.value = edgeType
  visibleRight2.value = true
}

const openCreateEdgeField = (edgeType) => {
  selectedEdgeType.value = edgeType
  visibleRight3.value = true
}

const openCreateRule = (edgeType) => {
  selectedEdgeType.value = edgeType
  visibleRight4.value = true
}
</script>
