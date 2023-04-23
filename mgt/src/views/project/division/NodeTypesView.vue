<template>
  <main style="max-width: 768px; margin: auto">
    <NodeTypeListOrganism
      :division-id="divisionId"
      @click:createNodeType="() => (visibleRight = true)"
      @click:updateNodeType="(nodeType) => openUpdateNodeType(nodeType)"
      @click:createNodeField="(nodeType) => openCreateNodeField(nodeType)"
    />
  </main>
  <Sidebar
    v-model:visible="visibleRight"
    position="right"
  >
    <NodeTypeCreateOrganism
      :division-id="divisionId"
      @created="visibleRight = false"
    />
  </Sidebar>
  <Sidebar
    v-model:visible="visibleRight2"
    position="right"
  >
    <NodeTypeUpdateOrganism
      :node-type="selectedNodeType"
      @created="visibleRight2 = false"
    />
  </Sidebar>
  <Sidebar
    v-model:visible="visibleRight3"
    position="right"
  >
    <NodeFieldCreateOrganism
      :node-type="selectedNodeType"
      @created="visibleRight3 = false"
    />
  </Sidebar>
</template>

<script setup lang="ts">
import { ref } from 'vue'

import NodeFieldCreateOrganism from '@/components/organisms/NodeFieldCreateOrganism.vue'
import NodeTypeCreateOrganism from '@/components/organisms/NodeTypeCreateOrganism.vue'
import NodeTypeListOrganism from '@/components/organisms/NodeTypeListOrganism.vue'
import NodeTypeUpdateOrganism from '@/components/organisms/NodeTypeUpdateOrganism.vue'

defineProps<{
  divisionId: string;
}>()

const visibleRight = ref(false)
const visibleRight2 = ref(false)
const visibleRight3 = ref(false)
const selectedNodeType = ref({})

const openUpdateNodeType = (nodeType) => {
  selectedNodeType.value = nodeType
  visibleRight2.value = true
}

const openCreateNodeField = (nodeType) => {
  selectedNodeType.value = nodeType
  visibleRight3.value = true
}
</script>
