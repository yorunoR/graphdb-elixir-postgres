<template>
  <main style="max-width: 768px; margin: auto">
    <h1>Status</h1>
    <section>
      <div class="grid">
        <div class="p-3 col-12 md:col-6 lg:col-6 border-round panel-outline">
          <div v-if="subGraphData">
            <DataTable
              :value="mapToList(subGraphData.subGraphStatus)"
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
              :disabled="subGraphData.subGraphStatus.status"
              @click="() => clickStartSubGraph()"
            />
            <Button
              label="Stop"
              class="w-full mt-2"
              :disabled="!subGraphData.subGraphStatus.status"
              @click="() => clickStopSubGraph()"
            />
          </div>
        </div>
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

const { data: subGraphData } = useSubGraphStatusQuery({
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
