<template>
  <div class="flex justify-content-between align-items-center">
    <div class="text-left w-10">
      <div class="text-lg wrap">
        {{ $t('common.name') }}: {{ subGraphFilter.name }}
      </div>
    </div>
    <div class="text-right">
      <i
        class="pi pi-pencil ml-0"
        style="cursor: pointer"
        @click="() => emit('click:updateSubGraphFilter')"
      />
      <i
        class="pi pi-sign-in ml-3"
        style="cursor: pointer"
        @click="(_event) => moveToSubGraph(subGraphFilter.id)"
      />
    </div>
  </div>
</template>

<script setup lang="ts">
import type { SubGraphFilter } from '@/auto_generated/graphql'
import router from '@/router'

defineProps<{
  subGraphFilter: SubGraphFilter;
}>()

const emit = defineEmits<{
  (e: 'click:updateSubGraphFilter'): void;
}>()

const moveToSubGraph = (subGraphFilterId) => {
  router.push({
    name: 'search',
    params: {
      subGraphFilterId
    }
  })
}
</script>

<style scoped>
.wrap {
  overflow-wrap: break-word;
}
</style>
