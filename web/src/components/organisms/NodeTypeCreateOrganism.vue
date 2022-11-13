<template>
  <section>
    <h2>Create NodeType</h2>
    <NodeTypeFormMolecule
      is-create
      @update:values="(values) => (inputNodeType = values)"
      @update:meta="(meta) => (disabled = !meta.valid)"
    />
    <Button
      class="mt-3 w-full"
      label="Submit"
      :disabled="disabled"
      @click="clickCreateNodeType"
    />
  </section>
</template>

<script setup lang="ts">
import { ref } from 'vue'

import { useCreateNodeTypeMutation } from '@/auto_generated/graphql'
import NodeTypeFormMolecule from '@/components/molecules/NodeTypeFormMolecule.vue'

const props = defineProps<{
  divisionId: string;
}>()

const emit = defineEmits<{
  (e: 'created', status: boolean): void;
}>()

const { executeMutation: createNodeType } = useCreateNodeTypeMutation()

const disabled = ref(true)
const inputNodeType = ref({})

let stopDoubleClick = false
const clickCreateNodeType = async () => {
  if (stopDoubleClick) return
  stopDoubleClick = true
  await createNodeType({
    divisionId: props.divisionId,
    nodeType: inputNodeType.value
  })
  emit('created', true)
  stopDoubleClick = false
}
</script>
