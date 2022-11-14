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
    <InputText
      v-model="uid"
      class="w-full"
      type="text"
      placeholder="Uid"
    />
    <div class="mt-2 p-error">
      {{ uidErrors.join(" ") }}
    </div>
  </div>
  <div class="mt-4">
    <div
      v-for="option in options"
      :key="option"
      class="mt-2"
    >
      <RadioButton
        v-model="type"
        :input-id="option"
        name="type"
        :value="option"
      />
      <label
        :for="option"
        class="ml-2"
      >{{ option }}</label>
    </div>
  </div>
</template>

<script setup lang="ts">
import { useField, useForm } from 'vee-validate'
import type { FormMeta } from 'vee-validate'
import { ref, watch } from 'vue'

import type { InputEdgeField } from '@/auto_generated/graphql'

const props = defineProps<{
  name?: string;
  type?: string;
  uid?: string;
}>()

const emit = defineEmits<{
  (e: 'update:meta', meta: FormMeta): void;
  (e: 'update:values', values: InputEdgeField): void;
}>()

const { meta, values } = useForm({
  initialValues: {
    name: props.name,
    type: props.type,
    uid: props.uid
  }
})

const options = ref<string[]>(['STRING', 'INTEGER', 'DATETIME'])

const isRequired = (value) => (value ? true : 'This field is required')
const { value: name, errors: nameErrors } = useField('name', isRequired)
const { value: type, errors: _typeErrors } = useField('type', isRequired)
const { value: uid, errors: uidErrors } = useField('uid', isRequired)

watch(meta, () => {
  emit('update:meta', meta.value)
  emit('update:values', values)
})
</script>
