<template>
  <div class="flex justify-content-between align-items-center">
    <div class="text-left w-10">
      <div class="text-lg wrap">
        {{ $t('common.name') }}: {{ edgeType.name }}
      </div>
      <div class="text-base font-semibold mt-2">
        {{ $t('common.uid') }}: {{ edgeType.uid }}
      </div>
      <div class="mt-2">
        <span
          v-for="edgeField in edgeType.edgeFields"
          :key="objId(edgeField)"
        >
          <Chip class="mt-2 mr-2 px-3 primary-color">
            <div class="h-2rem flex align-items-center">
              {{
                cutString(edgeField.name, 7) +
                  " :" +
                  edgeField.type.toLowerCase()
              }}
            </div>
          </Chip>
        </span>
      </div>
    </div>
    <div class="text-right">
      <i
        class="pi pi-plus"
        style="cursor: pointer"
        @click="() => emit('click:createEdgeField')"
      />
      <i
        class="pi pi-pencil ml-3"
        style="cursor: pointer"
        @click="() => emit('click:updateEdgeType')"
      />
    </div>
  </div>
  <div class="mt-3 text-left">
    <strong>{{ $t('rule.title') }}</strong>
    <ul class="mt-1">
      <li
        v-for="rule in edgeType.rules"
        :key="objId(rule)"
        class="list"
      >
        <div>{{ $t('common.name') }}: {{ rule.name }}</div>
        <div class="mt-1">
          StartNodeType: {{ rule.startNodeType.name }}
        </div>
        <div class="mt-1">
          EndNodeType: {{ rule.endNodeType.name }}
        </div>
      </li>
    </ul>
    <Button
      class="w-full mt-2 p-button-outlined"
      :label="$t('rule.add')"
      @click="() => emit('click:createRule')"
    />
  </div>
</template>

<script setup lang="ts">
import type { EdgeType } from '@/auto_generated/graphql'
import { objId } from '@/services/utils'

defineProps<{
  edgeType: EdgeType;
}>()

const emit = defineEmits<{
  (e: 'click:createEdgeField'): void;
  (e: 'click:updateEdgeType'): void;
  (e: 'click:createRule'): void;
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
