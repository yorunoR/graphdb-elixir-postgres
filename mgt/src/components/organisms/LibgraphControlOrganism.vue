<template>
  <section>
    <h2>Libgraph</h2>
    <GraphControlFormMolecule
      v-if="data"
      :subGraphFilterId="subGraphFilterId"
      :graphStatus="data.libgraphStatus"
      :result="commandData?.libgraphCommand"
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
  useLibgraphStatusQuery,
  useStartLibgraphMutation,
  useStopLibgraphMutation,
  useLibgraphCommandQuery,
  useCreateResultMutation
} from '@/auto_generated/graphql'
import GraphControlFormMolecule from '@/components/molecules/GraphControlFormMolecule.vue'

const props = defineProps<{
  subGraphFilterId: string;
}>()

const variables = ref({})
const pause = ref(true)

const { data } = useLibgraphStatusQuery({
  variables: { subGraphFilterId: props.subGraphFilterId },
  context: { additionalTypenames: ['Edge', 'Node', 'SubGraphFilter'] }
})

const { executeMutation: start } = useStartLibgraphMutation()
const { executeMutation: stop } = useStopLibgraphMutation()
const { executeMutation: createResult } = useCreateResultMutation()

const clickStart = () => {
  start({ subGraphFilterId: props.subGraphFilterId })
}

const clickStop = () => {
  stop({ subGraphFilterId: props.subGraphFilterId })
}

const { data: commandData, fetching } = useLibgraphCommandQuery({
  variables,
  requestPolicy: 'network-only',
  pause
})

const clickCommand = (newVariables) => {
  variables.value = newVariables
  pause.value = false
}

const clickSave = (saveData) => {
  const { openedAt, divisionChangedAt, subGraphFilterChangedAt } = data.value.libgraphStatus
  const { command, opts } = saveData
  const resultProps = commandData.value.libgraphCommand.props.map(item => {
    return { key: item.key, val: item.val }
  })
  createResult({
    subGraphFilterId: props.subGraphFilterId,
    agency: 'Libgraph',
    command,
    result: {
      name: 'Libgraph:' + command,
      args: opts,
      openedAt,
      divisionChangedAt,
      subGraphFilterChangedAt,
      props: resultProps
    }
  })
}
</script>
