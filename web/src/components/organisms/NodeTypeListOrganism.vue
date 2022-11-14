<template>
  <h1>NodeTypes</h1>
  <section>
    <Button
      class="w-full"
      label="Create"
      @click="() => emit('click:createNodeType')"
    />
  </section>
  <section>
    <div
      v-if="fetching"
      class="mt-4"
    >
      Loading...
    </div>
    <div
      v-else-if="error"
      class="mt-4"
    >
      Oh no... {{ error }}
    </div>
    <div v-else>
      <ul v-if="data">
        <li
          v-for="nodeType in data.division.nodeTypes"
          :key="nodeType.id"
        >
          <NodeTypeItemMolecule
            :node-type="nodeType"
            @click:updateNodeType="() => emit('click:updateNodeType', nodeType)"
            @click:createNodeField="
              () => emit('click:createNodeField', nodeType)
            "
          />
        </li>
      </ul>
    </div>
  </section>
</template>

<script setup lang="ts">
import type { NodeType } from '@/auto_generated/graphql'
import { callDivisionNodeTypesQuery } from '@/call/queries'
import NodeTypeItemMolecule from '@/components/molecules/NodeTypeItemMolecule.vue'

const props = defineProps<{
  divisionId: string;
}>()

const emit = defineEmits<{
  (e: 'click:createNodeType');
  (e: 'click:updateNodeType', nodeType: NodeType);
  (e: 'click:createNodeField', nodeType: NodeType);
}>()

const { fetching, error, data } = callDivisionNodeTypesQuery(props.divisionId)
</script>
