<template>
  <div>
    <InputText
      v-model="name"
      class="w-full"
      type="text"
      placeholder="Name"
    />
    <div class="mt-2 p-error">
      {{ nameErrors.join(" ") }}
    </div>
  </div>
  <div class="mt-4">
    <strong>Start node</strong>
    <div
      v-for="option in options ?? []"
      :key="option.id"
      class="mt-2"
    >
      <RadioButton
        v-model="startNodeTypeId"
        :input-id="`startNodeType-${option.id}`"
        name="startNodeTypeId"
        :value="option.id"
      />
      <label
        :for="`startNodeType-${option.id}`"
        class="ml-2 cursor-pointer"
      >{{
        option.name
      }}</label>
    </div>
  </div>
  <div class="mt-4">
    <strong>End node</strong>
    <div
      v-for="option in options ?? []"
      :key="option.id"
      class="mt-2"
    >
      <RadioButton
        v-model="endNodeTypeId"
        :input-id="`endNodeType-${option.id}`"
        name="endNodeTypeId"
        :value="option.id"
      />
      <label
        :for="`endNodeType-${option.id}`"
        class="ml-2 cursor-pointer"
      >{{
        option.name
      }}</label>
    </div>
  </div>
</template>

<script setup lang="ts">
import { useField, useForm } from 'vee-validate'
import type { FormMeta } from 'vee-validate'
import { watch } from 'vue'

import type { InputRule, NodeType } from '@/auto_generated/graphql'

const props = defineProps<{
  name?: string;
  startNodeTypeId?: string;
  endNodeTypeId?: string;
  options?: [NodeType];
}>()

const emit = defineEmits<{
  (e: 'update:meta', meta: FormMeta): void;
  (e: 'update:values', values: InputRule): void;
}>()

const { meta, values } = useForm({
  initialValues: {
    name: props.name,
    startNodeTypeId: props.startNodeTypeId,
    endNodeTypeId: props.endNodeTypeId
  }
})

const isRequired = (value) => (value ? true : 'This field is required')
const { value: name, errors: nameErrors } = useField('name', isRequired)
const { value: startNodeTypeId, errors: _startNodeTypeIdErrors } = useField(
  'startNodeTypeId',
  isRequired
)
const { value: endNodeTypeId, errors: _endNodeTypeIdErrors } = useField(
  'endNodeTypeId',
  isRequired
)

watch(meta, () => {
  emit('update:meta', meta.value)
  emit('update:values', values)
})
</script>
