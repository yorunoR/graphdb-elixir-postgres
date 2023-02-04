<template>
  <section>
    <h2>SubGraph</h2>
    <GraphControlFormMolecule
      v-if="data"
      :subGraphFilterId="subGraphFilterId"
      :graphStatus="data.subGraphStatus"
      :result="commandData?.subGraphCommand"
      :fetching="fetching"
      @start="() => clickStart()"
      @stop="() => clickStop()"
      @command="(newVariables) => clickCommand(newVariables)"
      @save="(saveData) => clickSave(saveData)"
    />
  </section>
</template>

<script setup lang="ts">
import { ref } from 'vue'

import {
  useSubGraphStatusQuery,
  useStartSubGraphMutation,
  useStopSubGraphMutation,
  useSubGraphCommandQuery,
  useCreateResultMutation
} from '@/auto_generated/graphql'
import GraphControlFormMolecule from '@/components/molecules/GraphControlFormMolecule.vue'

const props = defineProps<{
  subGraphFilterId: string;
}>()

const variables = ref({})
const pause = ref(true)

const { data } = useSubGraphStatusQuery({
  variables: { subGraphFilterId: props.subGraphFilterId },
  context: { additionalTypenames: ['Edge', 'Node', 'SubGraphFilter'] }
})

const { executeMutation: start } = useStartSubGraphMutation()
const { executeMutation: stop } = useStopSubGraphMutation()
const { executeMutation: createResult } = useCreateResultMutation()

const clickStart = () => {
  start({ subGraphFilterId: props.subGraphFilterId })
}

const clickStop = () => {
  stop({ subGraphFilterId: props.subGraphFilterId })
}

const { data: commandData, fetching } = useSubGraphCommandQuery({
  variables,
  requestPolicy: 'network-only',
  pause
})

const clickCommand = (newVariables) => {
  variables.value = newVariables
  pause.value = false
}

const clickSave = (saveData) => {
  const { openedAt, divisionChangedAt, subGraphFilterChangedAt } = data.value.subGraphStatus
  const { command, opts } = saveData
  const resultProps = commandData.value.subGraphCommand.props.map(item => {
    return { key: item.key, val: item.val }
  })
  createResult({
    subGraphFilterId: props.subGraphFilterId,
    agency: 'SubGraph',
    command,
    result: {
      name: 'SubGraph:' + command,
      args: opts,
      openedAt,
      divisionChangedAt,
      subGraphFilterChangedAt,
      props: resultProps
    }
  })
}
</script>
