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
  </div>
  <div class="mt-4">
    <strong>NodeType</strong>
    <div
      v-for="option in options ?? []"
      :key="objId(option.id)"
      class="mt-2"
    >
      <RadioButton
        v-model="nodeTypeId"
        :input-id="`nodeType-${option.id}`"
        name="nodeTypeId"
        :value="option.id"
        :disabled="!isCreate"
      />
      <label
        :for="`nodeType-${option.id}`"
        class="ml-2 cursor-pointer"
      >{{
        option.name
      }}</label>
    </div>
  </div>
  <div
    v-if="selectedNodeType"
    class="mt-4"
  >
    <strong>NodeFields</strong>
    <div
      v-for="nodeField in selectedNodeType.nodeFields"
      :key="objId(nodeField)"
      class="mt-2"
    >
      <InputText
        v-model="nodeFields[nodeField.uid]"
        class="w-full"
        :type="inputTextType(nodeField.type)"
        :placeholder="nodeField.name"
      />
    </div>
  </div>
</template>

<script setup lang="ts">
import { useField, useForm } from 'vee-validate'
import type { FormMeta } from 'vee-validate'
import { computed, reactive, watch } from 'vue'

import type { InputNode, Item, NodeType } from '@/auto_generated/graphql'
import { objId, listToMap } from '@/services/utils'

const props = defineProps<{
  isCreate?: boolean;
  name?: string;
  uid?: string;
  nodeTypeId?: string;
  props?: [Item];
  options?: [NodeType];
}>()

const emit = defineEmits<{
  (e: 'update:meta', meta: FormMeta): void;
  (e: 'update:values', values: InputNode): void;
}>()

const nodeFields = reactive(listToMap(props.props))

const { meta, values } = useForm({
  initialValues: {
    name: props.name,
    uid: props.uid,
    nodeTypeId: props.nodeTypeId
  }
})

const isRequired = (value) => (value ? true : 'This field is required')
const { value: name, errors: nameErrors } = useField('name', isRequired)
const { value: uid, errors: uidErrors } = useField('uid', isRequired)
const { value: nodeTypeId, errors: _nodeTypeIdErrors } = useField(
  'nodeTypeId',
  isRequired
)

const selectedNodeType = computed(() => {
  return props.options.find((nodeType) => nodeType.id === nodeTypeId.value)
})

watch([meta, nodeFields], () => {
  const uids = (selectedNodeType.value?.nodeFields ?? []).map((nodeField) => {
    return nodeField.uid
  })
  emit('update:meta', meta.value)
  emit('update:values', {
    ...values,
    props: Object.entries(nodeFields)
      .filter(([key, _val]) => uids.includes(key))
      .map(([key, val]) => ({ key, val }))
  })
})

const inputTextType = (type: string) => {
  return { STRING: 'text', INTEGER: 'number', DATETIME: 'datetime-local' }[
    type
  ]
}
</script>

<script lang="ts">
export default { inheritAttrs: false }
</script>
