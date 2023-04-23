<template>
  <main style="max-width: 768px; margin: auto">
    <h1>
      {{ $t('subGraph.searchCondition') }}
    </h1>
    <section
      v-if="data"
      class="text-left mt-4"
      style="padding: 0 5px"
    >
      <div class="grid">
        <div
          class="p-3 col-12 md:col-6 lg:col-6 border-round panel-outline"
        >
          <h2>{{ $t('node.title') }}</h2>
          <NodeSearchOrganism
            :divisionId="divisionId"
            :buttonLabel="$t('subGraph.save')"
            :initial="data.subGraphFilter.nodeFilter"
            @search="saveNodeFilter($event)"
          />
        </div>
        <div
          class="p-3 col-12 md:col-6 lg:col-6 border-round panel-outline"
        >
          <h2>{{ $t('edge.title') }}</h2>
          <EdgeSearchOrganism
            :divisionId="divisionId"
            :buttonLabel="$t('subGraph.save')"
            :initial="data.subGraphFilter.edgeFilter"
            @search="saveEdgeFilter($event)"
          />
        </div>
      </div>
    </section>
    <section
      v-if="data"
      class="mt-3"
    >
      <TabView
        ref="tabview"
        v-model:activeIndex="active"
      >
        <TabPanel :header="$t('division.nodes')">
          <ul v-if="nodesData">
            <li
              v-for="node in nodesData.nodes.entries"
              :key="node.id"
              class="list"
            >
              <NodeItemMolecule
                :node="node"
                @click:updateNode="() => {}"
              />
            </li>
          </ul>
          <Paginator
            :rows="nodesVariables.limit"
            :total-records="nodesData ? nodesData.nodes.total : 0"
            @page="onNodesPage($event)"
          />
        </TabPanel>
        <TabPanel :header="$t('division.edges')">
          <ul v-if="edgesData">
            <li
              v-for="edge in edgesData.nodeBoundEdges.entries"
              :key="edge.id"
              class="list"
            >
              <EdgeItemMolecule
                :edge="edge"
                @click:updateEdge="() => {}"
              />
            </li>
          </ul>
          <Paginator
            :rows="edgesVariables.limit"
            :total-records="edgesData ? edgesData.nodeBoundEdges.total : 0"
            @page="onEdgesPage($event)"
          />
        </TabPanel>
      </TabView>
    </section>
  </main>
</template>

<script setup lang="ts">
import { ref, watch } from 'vue'

import { useNodeBoundEdgesQuery, useNodesQuery, useSubGraphFilterQuery, useUpdateSubGraphFilterMutation } from '@/auto_generated/graphql'
import EdgeItemMolecule from '@/components/molecules/EdgeItemMolecule.vue'
import NodeItemMolecule from '@/components/molecules/NodeItemMolecule.vue'
import EdgeSearchOrganism from '@/components/organisms/EdgeSearchOrganism.vue'
import NodeSearchOrganism from '@/components/organisms/NodeSearchOrganism.vue'

const props = defineProps<{
  divisionId: string;
  subGraphFilterId: string;
}>()

const active = ref(0)
const pause = ref(true)

const { executeMutation: updateSubGraphFilter } =
  useUpdateSubGraphFilterMutation()

const nodesVariables = ref({
  divisionId: props.divisionId,
  offset: 0,
  limit: 10
})

const edgesVariables = ref({
  divisionId: props.divisionId,
  offset: 0,
  limit: 10
})

const { data } = useSubGraphFilterQuery({
  variables: { subGraphFilterId: props.subGraphFilterId }
})

watch([data], () => {
  if (data.value == null) {
    pause.value = true
  } else {
    nodesVariables.value.q = data.value.subGraphFilter.nodeFilter
    edgesVariables.value.q = data.value.subGraphFilter.edgeFilter
    edgesVariables.value.qNode = data.value.subGraphFilter.nodeFilter
    pause.value = false
  }
}, { immediate: true })

const { data: nodesData } = useNodesQuery({
  variables: nodesVariables,
  context: { additionalTypenames: ['Node'] },
  pause
})

const { data: edgesData } = useNodeBoundEdgesQuery({
  variables: edgesVariables,
  context: { additionalTypenames: ['Edge', 'Node'] },
  pause
})

const saveNodeFilter = (parameters) => {
  updateSubGraphFilter({
    subGraphFilterId: props.subGraphFilterId,
    qNode: parameters
  })
  active.value = 0
}

const saveEdgeFilter = (parameters) => {
  updateSubGraphFilter({
    subGraphFilterId: props.subGraphFilterId,
    qEdge: parameters
  })
  active.value = 1
}

const onNodesPage = (event) => {
  nodesVariables.value.offset = event.first
}

const onEdgesPage = (event) => {
  edgesVariables.value.offset = event.first
}
</script>

<style scoped>
.panel-outline {
  outline: 1px solid gray;
  outline-offset: -4px;
}
</style>
