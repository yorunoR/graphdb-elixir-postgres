<template>
  <section>
    <h2>
      {{ $t('edgeType.addEdgeField') }}
    </h2>
    <EdgeFieldFormMolecule
      @update:values="(values) => (inputEdgeField = values)"
      @update:meta="(meta) => (disabled = !meta.valid)"
    />
    <Button
      class="mt-3 w-full"
      :label="$t('common.submit')"
      :disabled="disabled"
      @click="clickAddEdgeField"
    />
  </section>
</template>

<script setup lang="ts">
import { ref } from 'vue'

import { useCreateEdgeFieldMutation } from '@/auto_generated/graphql'
import type { EdgeType } from '@/auto_generated/graphql'
import EdgeFieldFormMolecule from '@/components/molecules/EdgeFieldFormMolecule.vue'

const props = defineProps<{
  edgeType: EdgeType;
}>()

const emit = defineEmits<{
  (e: 'created', status: boolean): void;
}>()

const { executeMutation: createEdgeField } = useCreateEdgeFieldMutation()

const disabled = ref(true)
const inputEdgeField = ref({})

const clickAddEdgeField = async () => {
  await createEdgeField({
    edgeTypeId: props.edgeType.id,
    edgeField: inputEdgeField.value
  })
  emit('created', true)
}
</script>
