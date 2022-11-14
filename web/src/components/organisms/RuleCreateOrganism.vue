<template>
  <section v-if="data">
    <h2>Add Rule</h2>
    <RuleFormMolecule
      :options="data.division.nodeTypes"
      @update:values="(values) => (inputRule = values)"
      @update:meta="(meta) => (disabled = !meta.valid)"
    />
    <Button
      class="mt-3 w-full"
      label="Submit"
      :disabled="disabled"
      @click="clickAddRule"
    />
  </section>
</template>

<script setup lang="ts">
import { ref } from 'vue'

import { useCreateRuleMutation } from '@/auto_generated/graphql'
import type { EdgeType } from '@/auto_generated/graphql'
import { callDivisionNodeTypesQuery } from '@/call/queries'
import RuleFormMolecule from '@/components/molecules/RuleFormMolecule.vue'

const props = defineProps<{
  divisionId: string;
  edgeType: EdgeType;
}>()

const emit = defineEmits<{
  (e: 'created', status: boolean): void;
}>()

const { data } = callDivisionNodeTypesQuery(props.divisionId)

const { executeMutation: createRule } = useCreateRuleMutation()

const disabled = ref(true)
const inputRule = ref({})

const clickAddRule = async () => {
  await createRule({
    edgeTypeId: props.edgeType.id,
    rule: inputRule.value
  })
  emit('created', true)
}
</script>
