<template>
  <div class="flex justify-content-between align-items-center">
    <div class="text-left w-10">
      <div class="text-lg wrap">
        {{ $t('common.name') }}: {{ edge.name }}
      </div>
      <div class="text-base font-semibold mt-2">
        Start node: {{ edge.startNode.name }} ({{ edge.startNode.uid }}) - End
        node: {{ edge.endNode.name }} ({{ edge.endNode.uid }})
      </div>
      <div class="text-base mt-2">
        {{ $t('edgeType.title') }}: {{ edge.edgeType.name }}
      </div>
    </div>
    <div class="text-right">
      <i
        class="pi pi-pencil ml-3"
        style="cursor: pointer"
        @click="() => emit('click:updateEdge', edge)"
      />
    </div>
  </div>
  <div class="text-left mt-2">
    <span
      v-for="prop in edge.props"
      :key="prop.uid"
    >
      <Chip class="mt-2 mr-2 px-3 primary-color">
        <div class="h-2rem flex align-items-center">
          {{ prop.key + ": " + prop.val }}
        </div>
      </Chip>
    </span>
  </div>
</template>

<script setup lang="ts">
import type { Edge } from '@/auto_generated/graphql'

defineProps<{
  edge: Edge;
}>()

const emit = defineEmits<{
  (e: 'click:updateEdge'): void;
}>()
</script>

<style scoped>
.wrap {
  overflow-wrap: break-word;
}
.primary-color {
  background: var(--primary-color);
  color: var(--primary-color-text);
}
</style>
