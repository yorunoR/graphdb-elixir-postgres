<template>
  <section v-if="data">
    <h2>
      {{ $t('node.update') }}
    </h2>
    <NodeFormMolecule
      v-bind="node"
      :options="data.division.nodeTypes"
      @update:values="(values) => (inputNode = values)"
      @update:meta="(meta) => (disabled = !meta.valid)"
    />
    <Button
      class="mt-3 w-full"
      :label="$t('common.submit')"
      :disabled="disabled"
      @click="clickUpdateNode"
    />
  </section>
</template>

<script setup lang="ts">
import { ref } from 'vue'

import { useUpdateNodeMutation } from '@/auto_generated/graphql'
import type { Node } from '@/auto_generated/graphql'
import { callDivisionNodeTypesQuery } from '@/call/queries'
import NodeFormMolecule from '@/components/molecules/NodeFormMolecule.vue'

const props = defineProps<{
  divisionId: string;
  node: Node;
}>()

const emit = defineEmits<{
  (e: 'updated', status: boolean): void;
}>()

const { data } = callDivisionNodeTypesQuery(props.divisionId)

const { executeMutation: updateNode } = useUpdateNodeMutation()

const disabled = ref(true)
const inputNode = ref({})

const clickUpdateNode = async () => {
  await updateNode({
    nodeId: props.node.id,
    node: inputNode.value
  })
  emit('updated', true)
}
</script>
