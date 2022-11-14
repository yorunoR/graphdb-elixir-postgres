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
  <div
    v-show="isCreate"
    class="mt-2"
  >
    <InputText
      v-model="uid"
      class="w-full"
      type="text"
      placeholder="UID"
    />
    <div class="mt-2 p-error">
      {{ uidErrors.join(" ") }}
    </div>
  </div>
</template>

<script setup lang="ts">
import { useField, useForm } from 'vee-validate'
import type { FormMeta } from 'vee-validate'
import { watch } from 'vue'

import type { InputNodeType } from '@/auto_generated/graphql'

const props = defineProps<{
  isCreate?: boolean;
  name?: string;
  uid?: string;
}>()

const emit = defineEmits<{
  (e: 'update:meta', meta: FormMeta): void;
  (e: 'update:values', values: InputNodeType): void;
}>()

const { meta, values } = useForm({
  initialValues: {
    name: props.name,
    uid: props.uid
  }
})

const isRequired = (value) => (value ? true : 'This field is required')
const { value: name, errors: nameErrors } = useField('name', isRequired)
const { value: uid, errors: uidErrors } = useField('uid', isRequired)

watch(meta, () => {
  emit('update:meta', meta.value)
  emit('update:values', values)
})
</script>

<script lang="ts">
export default { inheritAttrs: false }
</script>
