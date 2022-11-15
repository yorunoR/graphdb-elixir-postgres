<template>
  <section v-if="data && data.division">
    <h2>Create Node</h2>
    <NodeFormMolecule
      is-create
      :options="data.division.nodeTypes"
      @update:values="(values) => (inputNode = values)"
      @update:meta="(meta) => (disabled = !meta.valid)"
    />
    <Button
      class="mt-3 w-full"
      label="Submit"
      :disabled="disabled"
      @click="clickCreateNode"
    />
  </section>
</template>

<script setup lang="ts">
import { useToast } from 'primevue/usetoast'
import { ref } from 'vue'

import { useCreateNodeMutation } from '@/auto_generated/graphql'
import { callDivisionNodeTypesQuery } from '@/call/queries'
import NodeFormMolecule from '@/components/molecules/NodeFormMolecule.vue'

const props = defineProps<{
  divisionId: string;
}>()

const emit = defineEmits<{
  (e: 'created', status: boolean): void;
}>()

const toast = useToast()

const { data } = callDivisionNodeTypesQuery(props.divisionId)

const { executeMutation: createNode } = useCreateNodeMutation()

const disabled = ref(true)
const inputNode = ref({})

const clickCreateNode = async () => {
  const result = await createNode({
    node: inputNode.value
  })
  if (result.error) {
    toast.add({
      severity: 'error',
      summary: 'Create node',
      detail: result.error.message
    })
  } else {
    emit('created', true)
  }
}
</script>
