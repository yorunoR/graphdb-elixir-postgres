<template>
  <section>
    <h2>Add NodeField</h2>
    <NodeFieldFormMolecule
      @update:values="(values) => (inputNodeField = values)"
      @update:meta="(meta) => (disabled = !meta.valid)"
    />
    <Button
      class="mt-3 w-full"
      label="Submit"
      :disabled="disabled"
      @click="clickAddNodeField"
    />
  </section>
</template>

<script setup lang="ts">
import { ref } from 'vue'

import { useCreateNodeFieldMutation } from '@/auto_generated/graphql'
import type { NodeType } from '@/auto_generated/graphql'
import NodeFieldFormMolecule from '@/components/molecules/NodeFieldFormMolecule.vue'

const props = defineProps<{
  nodeType: NodeType;
}>()

const emit = defineEmits<{
  (e: 'created', status: boolean): void;
}>()

const { executeMutation: createNodeField } = useCreateNodeFieldMutation()

const disabled = ref(true)
const inputNodeField = ref({})

const clickAddNodeField = async () => {
  await createNodeField({
    nodeTypeId: props.nodeType.id,
    nodeField: inputNodeField.value
  })
  emit('created', true)
}
</script>
