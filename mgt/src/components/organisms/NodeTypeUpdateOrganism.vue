<template>
  <section>
    <h2>
      {{ $t('nodeType.update') }}
    </h2>
    <NodeTypeFormMolecule
      v-bind="nodeType"
      @update:values="(values) => (inputNodeType = values)"
      @update:meta="(meta) => (disabled = !meta.valid)"
    />
    <Button
      class="mt-3 w-full"
      :label="$t('common.submit')"
      :disabled="disabled"
      @click="clickUpdateNodeType"
    />
  </section>
</template>

<script setup lang="ts">
import { ref } from 'vue'

import { useUpdateNodeTypeMutation } from '@/auto_generated/graphql'
import type { NodeType } from '@/auto_generated/graphql'
import NodeTypeFormMolecule from '@/components/molecules/NodeTypeFormMolecule.vue'

const props = defineProps<{
  nodeType: NodeType;
}>()

const emit = defineEmits<{
  (e: 'created', status: boolean): void;
}>()

const { executeMutation: updateNodeType } = useUpdateNodeTypeMutation()

const disabled = ref(true)
const inputNodeType = ref({})

const clickUpdateNodeType = async () => {
  await updateNodeType({
    nodeTypeId: props.nodeType.id,
    nodeType: inputNodeType.value
  })
  emit('created', true)
}
</script>
