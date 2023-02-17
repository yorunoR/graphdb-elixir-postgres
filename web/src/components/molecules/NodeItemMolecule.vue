<template>
  <div class="flex justify-content-between align-items-center">
    <div class="text-left w-10">
      <div class="text-lg wrap">
        {{ $t('common.name') }}: {{ node.name }}
      </div>
      <div class="text-base font-semibold mt-2">
        {{ $t('common.uid') }}: {{ node.uid }}
      </div>
      <div class="text-base mt-2">
        {{ $t('nodeType.title') }}: {{ node.nodeType.name }}
      </div>
    </div>
    <div class="text-right">
      <i
        class="pi pi-pencil ml-3"
        style="cursor: pointer"
        @click="() => emit('click:updateNode', node)"
      />
    </div>
  </div>
  <div class="text-left mt-2">
    <span
      v-for="prop in node.props"
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
import type { Node } from '@/auto_generated/graphql'

defineProps<{
  node: Node;
}>()

const emit = defineEmits<{
  (e: 'click:updateNode'): void;
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
