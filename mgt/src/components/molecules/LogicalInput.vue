<template>
  <div class="flex flex-nowrap">
    <ToggleButton
      v-model="notComputed"
      on-label="NOT"
      off-label="NOT"
      on-icon="pi pi-check"
      off-icon="pi pi-minus"
      class="w-6rem text-xs p-2"
      aria-label="not"
    />
    <InputText
      v-model="textComputed"
      class="ml-2 flex-grow-1"
      type="text"
      :placeholder="placeholder"
    />
  </div>
  <div class="mt-2 p-error text-right">
    {{ errors }}
  </div>
  <div class="mt-3">
    <LogicalExpressionButtons
      :disabled="disabled"
      :showOr="showOr"
      @click:cancel="() => emit('click:cancel')"
      @click:and="() => emit('click:and')"
      @click:or="() => emit('click:or')"
    />
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'

import LogicalExpressionButtons from '@/components/molecules/LogicalExpressionButtons.vue'

const props = defineProps<{
  not: boolean,
  text?: string,
  placeholder: string;
  errors: string;
  showOr?: boolean;
  disabled: boolean;
}>()

const emit = defineEmits<{
  (e: 'click:cancel'): void;
  (e: 'click:and'): void;
  (e: 'click:or'): void;
  (e: 'update:not', not: boolean): void;
  (e: 'update:text', text: string): void;
}>()

const notComputed = computed({
  get: () => props.not,
  set: (value) => {
    emit('update:not', value)
  }
})

const textComputed = computed({
  get: () => props.text,
  set: (value) => {
    emit('update:text', value)
  }
})
</script>
