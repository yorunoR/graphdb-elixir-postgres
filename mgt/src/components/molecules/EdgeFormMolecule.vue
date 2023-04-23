<template>
  <div>
    <InputText
      v-model="name"
      class="w-full"
      type="text"
      :placeholder="$t('common.name')"
    />
    <div class="mt-2 p-error">
      {{ nameErrors.join(" ") }}
    </div>
    <div
      v-show="isCreate"
      class="mt-2"
    >
      <InputText
        v-model="startNodeUid"
        class="w-full"
        type="text"
        placeholder="Start node UID"
      />
      <div class="mt-2 p-error">
        {{ startNodeUidErrors.join(" ") }}
      </div>
      <InputText
        v-model="endNodeUid"
        class="w-full"
        type="text"
        placeholder="End node UID"
      />
      <div class="mt-2 p-error">
        {{ endNodeUidErrors.join(" ") }}
      </div>
    </div>
  </div>
  <div class="mt-4">
    <strong>
      {{ $t('edgeType.title') }}
    </strong>
    <div
      v-for="option in options ?? []"
      :key="objId(option.id)"
      class="mt-2"
    >
      <RadioButton
        v-model="edgeTypeId"
        :input-id="`edgeType-${option.id}`"
        name="edgeTypeId"
        :value="option.id"
        :disabled="!isCreate"
      />
      <label
        :for="`edgeType-${option.id}`"
        class="ml-2"
        :class="{ 'cursor-pointer': isCreate }"
      >
        {{ option.name }}
      </label>
    </div>
  </div>
  <div
    v-if="selectedEdgeType"
    class="mt-4"
  >
    <strong>
      {{ $t('edge.edgeField') }}
    </strong>
    <div
      v-for="edgeField in selectedEdgeType.edgeFields"
      :key="objId(edgeField)"
      class="mt-2"
    >
      <InputText
        v-model="edgeFields[edgeField.uid]"
        class="w-full"
        :type="inputTextType(edgeField.type)"
        :placeholder="edgeField.name"
      />
    </div>
  </div>
</template>

<script setup lang="ts">
import { useField, useForm } from 'vee-validate'
import type { FormMeta } from 'vee-validate'
import { computed, reactive, watch } from 'vue'

import type { InputEdge, Item, EdgeType } from '@/auto_generated/graphql'
import { objId, listToMap } from '@/services/utils'

const props = defineProps<{
  isCreate?: boolean;
  name?: string;
  edgeTypeId?: string;
  props?: [Item];
  options?: [EdgeType];
}>()

const emit = defineEmits<{
  (e: 'update:meta', meta: FormMeta): void;
  (e: 'update:values', values: InputEdge): void;
}>()

const edgeFields = reactive(listToMap(props.props))

const { meta, values } = useForm({
  initialValues: {
    name: props.name,
    edgeTypeId: props.edgeTypeId
  }
})

const isRequired = (value) => (value ? true : 'This field is required')
const isRequiredOnlyCreate = (value) =>
  !props.isCreate || value ? true : 'This field is required'
const { value: name, errors: nameErrors } = useField('name', isRequired)
const { value: startNodeUid, errors: startNodeUidErrors } = useField(
  'startNodeUid',
  isRequiredOnlyCreate
)
const { value: endNodeUid, errors: endNodeUidErrors } = useField(
  'endNodeUid',
  isRequiredOnlyCreate
)
const { value: edgeTypeId, errors: _edgeTypeIdErrors } = useField(
  'edgeTypeId',
  isRequired
)

const selectedEdgeType = computed(() => {
  return props.options.find((edgeType) => edgeType.id === edgeTypeId.value)
})

watch([meta, edgeFields], () => {
  const uids = (selectedEdgeType.value?.edgeFields ?? []).map((edgeField) => {
    return edgeField.uid
  })
  emit('update:meta', meta.value)
  emit('update:values', {
    ...values,
    props: Object.entries(edgeFields)
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
