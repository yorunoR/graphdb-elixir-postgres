<template>
  <div class="flex justify-content-between align-items-center">
    <div class="text-left w-10">
      <div class="text-lg wrap">
        {{ $t('common.name') }}: {{ nodeType.name }}
      </div>
      <div class="text-base font-semibold mt-2">
        {{ $t('common.uid') }}: {{ nodeType.uid }}
      </div>
      <div class="mt-2">
        <span
          v-for="nodeField in nodeType.nodeFields"
          :key="nodeField.id"
        >
          <Chip class="mt-2 mr-2 px-3 primary-color">
            <div class="h-2rem flex align-items-center">
              {{
                cutString(nodeField.name, 7) +
                  " :" +
                  nodeField.type.toLowerCase()
              }}
            </div>
          </Chip>
        </span>
      </div>
    </div>
    <div class="text-right">
      <i
        class="pi pi-plus cursor-pointer"
        @click="() => emit('click:createNodeField')"
      />
      <i
        class="pi pi-pencil ml-3 cursor-pointer"
        @click="() => emit('click:updateNodeType')"
      />
    </div>
  </div>
</template>

<script setup lang="ts">
import type { NodeType } from '@/auto_generated/graphql'

defineProps<{
  nodeType: NodeType;
}>()

const emit = defineEmits<{
  (e: 'click:createNodeField'): void;
  (e: 'click:updateNodeType'): void;
}>()

const cutString = (str, len) => {
  if (str.length > len) {
    return str.substring(0, len - 2) + '...'
  }
  return str
}
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
