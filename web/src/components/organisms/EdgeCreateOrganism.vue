<template>
  <section v-if="data">
    <h2>Create Edge</h2>
    <EdgeFormMolecule
      is-create
      :options="data.division.edgeTypes"
      @update:values="(values) => (inputEdge = values)"
      @update:meta="(meta) => (disabled = !meta.valid)"
    />
    <Button
      class="mt-3 w-full"
      label="Submit"
      :disabled="disabled"
      @click="clickCreateEdge"
    />
  </section>
</template>

<script setup lang="ts">
import { useToast } from 'primevue/usetoast'
import { ref } from 'vue'

import { useCreateEdgeMutation } from '@/auto_generated/graphql'
import { callDivisionEdgeTypesQuery } from '@/call/queries'
import EdgeFormMolecule from '@/components/molecules/EdgeFormMolecule.vue'

const props = defineProps<{
  divisionId: string;
}>()

const emit = defineEmits<{
  (e: 'created', status: boolean): void;
}>()

const toast = useToast()

const { data } = callDivisionEdgeTypesQuery(props.divisionId)

const { executeMutation: createEdge } = useCreateEdgeMutation()

const disabled = ref(true)
const inputEdge = ref({})

const clickCreateEdge = async () => {
  const result = await createEdge({
    edge: inputEdge.value
  })
  if (result.error) {
    toast.add({
      severity: 'error',
      summary: 'Create edge',
      detail: result.error.message
    })
  } else {
    emit('created', true)
  }
}
</script>
