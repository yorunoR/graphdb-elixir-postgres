<template>
  <main style="max-width: 768px; margin: auto">
    <h1>Status</h1>
    <section>
      <div v-if="data">
        <DataTable
          :value="mapToList(data.subGraphStatus)"
          responsive-layout="scroll"
        >
          <Column
            field="key"
            header="key"
          />
          <Column
            field="val"
            header="val"
          />
        </DataTable>
        <Button
          label="Start"
          class="w-full mt-4"
          :disabled="data.subGraphStatus.status"
          @click="() => clickStartSubGraph()"
        />
        <Button
          label="Stop"
          class="w-full mt-2"
          :disabled="!data.subGraphStatus.status"
          @click="() => clickStopSubGraph()"
        />
      </div>
    </section>
  </main>
</template>

<script setup lang="ts">
import { useSubGraphStatusQuery, useStartSubGraphMutation, useStopSubGraphMutation } from '@/auto_generated/graphql'
import { mapToList } from '@/services/utils'

const props = defineProps<{
  divisionId: string;
  subGraphFilterId: string;
}>()

const { data } = useSubGraphStatusQuery({
  variables: { subGraphFilterId: props.subGraphFilterId },
  context: { additionalTypenames: ['Edge', 'Node', 'SubGraphFilter'] }
})

const { executeMutation: startSubGraph } = useStartSubGraphMutation()
const { executeMutation: stopSubGraph } = useStopSubGraphMutation()

const clickStartSubGraph = () => {
  startSubGraph({ subGraphFilterId: props.subGraphFilterId })
}

const clickStopSubGraph = () => {
  stopSubGraph({ subGraphFilterId: props.subGraphFilterId })
}
</script>
