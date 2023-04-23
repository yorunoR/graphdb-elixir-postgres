<template>
  <main style="max-width: 768px; margin: auto">
    <h1>
      {{ $t('division.uploadCsv') }}
    </h1>
    <section
      v-if="nodeTypesData && nodeTypesData.division"
      class="text-left mt-4"
    >
      <h2>
        {{ $t('node.title') }}
      </h2>
      <div class="grid">
        <div
          v-for="nodeType in nodeTypesData.division.nodeTypes"
          :key="nodeType.id"
          class="p-3 col-12 md:col-6 lg:col-6 border-round panel-outline"
        >
          <div>
            <strong>{{ $t('nodeType.title') }}: {{ nodeType.name }}</strong>
          </div>
          <div class="mt-2">
            {{ $t('common.uid') }}: {{ nodeType.uid }}
          </div>
          <NodesCsvDownloadLinkMolecule
            class="mt-2"
            :filename="nodeType.name"
            :records="nodeType.nodeFields"
          />
          <hr>
          <NodesUploadOrganism :node-type="nodeType" />
        </div>
      </div>
    </section>
    <section
      v-if="edgeTypesData && edgeTypesData.division"
      class="text-left mt-4"
    >
      <h2>
        {{ $t('edge.title') }}
      </h2>
      <div class="grid">
        <div
          v-for="edgeType in edgeTypesData.division.edgeTypes"
          :key="edgeType.id"
          class="p-3 col-12 md:col-6 lg:col-6 border-round panel-outline"
        >
          <div>
            <strong>{{ $t('edgeType.title') }}: {{ edgeType.name }}</strong>
          </div>
          <div class="mt-2">
            {{ $t('common.uid') }}: {{ edgeType.uid }}
          </div>
          <EdgesCsvDownloadLinkMolecule
            class="mt-2"
            :filename="edgeType.name"
            :records="edgeType.edgeFields"
          />
          <hr>
          <EdgesUploadOrganism :edge-type="edgeType" />
        </div>
      </div>
    </section>
  </main>
</template>

<script setup lang="ts">
import { callDivisionNodeTypesQuery, callDivisionEdgeTypesQuery } from '@/call/queries'
import EdgesCsvDownloadLinkMolecule from '@/components/molecules/EdgesCsvDownloadLinkMolecule.vue'
import NodesCsvDownloadLinkMolecule from '@/components/molecules/NodesCsvDownloadLinkMolecule.vue'
import EdgesUploadOrganism from '@/components/organisms/EdgesUploadOrganism.vue'
import NodesUploadOrganism from '@/components/organisms/NodesUploadOrganism.vue'

const props = defineProps<{
  divisionId: string;
}>()

const { data: nodeTypesData } = callDivisionNodeTypesQuery(
  props.divisionId
)
const { data: edgeTypesData } = callDivisionEdgeTypesQuery(
  props.divisionId
)
</script>

<style scoped>
.panel-outline {
  outline: 1px solid gray;
  outline-offset: -4px;
}
</style>
