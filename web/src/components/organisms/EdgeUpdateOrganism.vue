<template>
  <section v-if="data">
    <h2>
      {{ $t('edge.update') }}
    </h2>
    <EdgeFormMolecule
      v-bind="edge"
      :options="data.division.edgeTypes"
      @update:values="(values) => (inputEdge = values)"
      @update:meta="(meta) => (disabled = !meta.valid)"
    />
    <Button
      class="mt-3 w-full"
      :label="$t('common.submit')"
      :disabled="disabled"
      @click="clickUpdateEdge"
    />
  </section>
</template>

<script setup lang="ts">
import { ref } from 'vue'

import { useUpdateEdgeMutation } from '@/auto_generated/graphql'
import type { Edge } from '@/auto_generated/graphql'
import { callDivisionEdgeTypesQuery } from '@/call/queries'
import EdgeFormMolecule from '@/components/molecules/EdgeFormMolecule.vue'

const props = defineProps<{
  divisionId: string;
  edge: Edge;
}>()

const emit = defineEmits<{
  (e: 'updated', status: boolean): void;
}>()

const { data } = callDivisionEdgeTypesQuery(props.divisionId)

const { executeMutation: updateEdge } = useUpdateEdgeMutation()

const disabled = ref(true)
const inputEdge = ref({})

const clickUpdateEdge = async () => {
  await updateEdge({
    edgeId: props.edge.id,
    edge: inputEdge.value
  })
  emit('updated', true)
}
</script>
