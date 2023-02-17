<template>
  <main style="max-width: 768px; margin: auto">
    <NodeListOrganism
      :division-id="divisionId"
      @click:createNode="() => (visibleRight = true)"
      @click:updateNode="(node) => openUpdateNode(node)"
    />
  </main>
  <Sidebar
    v-model:visible="visibleRight"
    position="right"
  >
    <NodeCreateOrganism
      :division-id="divisionId"
      @created="visibleRight = false"
    />
  </Sidebar>
  <Sidebar
    v-model:visible="visibleRight2"
    position="right"
  >
    <NodeUpdateOrganism
      :division-id="divisionId"
      :node="selectedNode"
      @updated="visibleRight2 = false"
    />
  </Sidebar>
</template>

<script setup lang="ts">
import { ref } from 'vue'

import NodeCreateOrganism from '@/components/organisms/NodeCreateOrganism.vue'
import NodeListOrganism from '@/components/organisms/NodeListOrganism.vue'
import NodeUpdateOrganism from '@/components/organisms/NodeUpdateOrganism.vue'

defineProps<{
  divisionId: string;
}>()

const visibleRight = ref(false)
const visibleRight2 = ref(false)
const selectedNode = ref({})

const openUpdateNode = (node) => {
  selectedNode.value = node
  visibleRight2.value = true
}
</script>
