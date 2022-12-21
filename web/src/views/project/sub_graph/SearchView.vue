<template>
  <main style="max-width: 768px; margin: auto">
    <h1>Search condition</h1>
    <section
      class="text-left mt-4"
      style="padding: 0 5px"
    >
      <div
        v-if="data"
        class="grid"
      >
        <div
          class="p-3 col-12 md:col-6 lg:col-6 border-round panel-outline"
        >
          <h2>Nodes</h2>
          <NodeSearchOrganism
            :divisionId="divisionId"
            buttonLabel="Save"
            @search="saveNodeFilter($event)"
          />
        </div>
        <div
          class="p-3 col-12 md:col-6 lg:col-6 border-round panel-outline"
        >
          <h2>Edges</h2>
          <EdgeSearchOrganism
            :divisionId="divisionId"
            buttonLabel="Save"
            @search="saveEdgeFilter($event)"
          />
        </div>
      </div>
    </section>
    <section
      class="mt-3"
    >
      <TabView
        ref="tabview"
        v-model:activeIndex="active"
      >
        <TabPanel header="Nodes">
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
        <TabPanel header="Edges">
          <ul v-if="edgesData">
            <li
              v-for="edge in edgesData.edges.entries"
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
            :total-records="edgesData ? edgesData.edges.total : 0"
            @page="onEdgesPage($event)"
          />
        </TabPanel>
      </TabView>
    </section>
  </main>
</template>

<script setup lang="ts">
import { ref } from 'vue'

import { useEdgesQuery, useNodesQuery, useSubGraphFilterQuery } from '@/auto_generated/graphql'
import EdgeItemMolecule from '@/components/molecules/EdgeItemMolecule.vue'
import NodeItemMolecule from '@/components/molecules/NodeItemMolecule.vue'
import EdgeSearchOrganism from '@/components/organisms/EdgeSearchOrganism.vue'
import NodeSearchOrganism from '@/components/organisms/NodeSearchOrganism.vue'

const props = defineProps<{
  divisionId: string;
  subGraphFilterId: string;
}>()

const active = ref(0)

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

const { data: nodesData } = useNodesQuery({
  variables: nodesVariables,
  context: { additionalTypenames: ['Node'] }
})

const { data: edgesData } = useEdgesQuery({
  variables: edgesVariables,
  context: { additionalTypenames: ['Edge'] }
})

const { data } = useSubGraphFilterQuery({
  variables: { subGraphFilterId: props.subGraphFilterId }
})

const saveNodeFilter = (parameters) => {
  nodesVariables.value.q = parameters
  active.value = 0
}

const saveEdgeFilter = (parameters) => {
  edgesVariables.value.q = parameters
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
