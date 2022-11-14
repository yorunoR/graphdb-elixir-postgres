<template>
  <section>
    <h2>Create EdgeType</h2>
    <EdgeTypeFormMolecule
      is-create
      @update:values="(values) => (inputEdgeType = values)"
      @update:meta="(meta) => (disabled = !meta.valid)"
    />
    <Button
      class="mt-3 w-full"
      label="Submit"
      :disabled="disabled"
      @click="clickCreateEdgeType"
    />
  </section>
</template>

<script setup lang="ts">
import { ref } from 'vue'

import { useCreateEdgeTypeMutation } from '@/auto_generated/graphql'
import EdgeTypeFormMolecule from '@/components/molecules/EdgeTypeFormMolecule.vue'

const props = defineProps<{
  divisionId: string;
}>()

const emit = defineEmits<{
  (e: 'created', status: boolean): void;
}>()

const { executeMutation: createEdgeType } = useCreateEdgeTypeMutation()

const disabled = ref(true)
const inputEdgeType = ref({})

const clickCreateEdgeType = async () => {
  await createEdgeType({
    divisionId: props.divisionId,
    edgeType: inputEdgeType.value
  })
  emit('created', true)
}
</script>
