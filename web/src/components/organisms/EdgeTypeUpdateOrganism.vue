<template>
  <section>
    <h2>Update EdgeType</h2>
    <EdgeTypeFormMolecule
      v-bind="edgeType"
      @update:values="(values) => (inputEdgeType = values)"
      @update:meta="(meta) => (disabled = !meta.valid)"
    />
    <Button
      class="mt-3 w-full"
      label="Submit"
      :disabled="disabled"
      @click="clickUpdateEdgeType"
    />
  </section>
</template>

<script setup lang="ts">
import { ref } from 'vue'

import { useUpdateEdgeTypeMutation } from '@/auto_generated/graphql'
import type { InputEdgeType } from '@/auto_generated/graphql'
import EdgeTypeFormMolecule from '@/components/molecules/EdgeTypeFormMolecule.vue'

const props = defineProps<{
  edgeType: InputEdgeType;
}>()

const emit = defineEmits<{
  (e: 'created', status: boolean): void;
}>()

const { executeMutation: updateEdgeType } = useUpdateEdgeTypeMutation()

const disabled = ref(true)
const inputEdgeType = ref({})

const clickUpdateEdgeType = async () => {
  await updateEdgeType({
    edgeTypeId: props.edgeType.id,
    edgeType: inputEdgeType.value
  })
  emit('created', true)
}
</script>
