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
    />
  </section>
</template>

<script setup lang="ts">
import { ref } from 'vue'

import {
  useSubGraphStatusQuery,
  useStartSubGraphMutation,
  useStopSubGraphMutation,
  useSubGraphCommandQuery
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
</script>
