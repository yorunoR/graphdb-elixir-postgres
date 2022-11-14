<template>
  <h1>EdgeTypes</h1>
  <section>
    <Button
      class="w-full"
      label="Create"
      @click="() => emit('click:createEdgeType')"
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
          v-for="edgeType in data.division.edgeTypes"
          :key="edgeType.id"
        >
          <EdgeTypeItemMolecule
            :edge-type="edgeType"
            @click:updateEdgeType="() => emit('click:updateEdgeType', edgeType)"
            @click:createEdgeField="
              () => emit('click:createEdgeField', edgeType)
            "
            @click:createRule="() => emit('click:createRule', edgeType)"
          />
        </li>
      </ul>
    </div>
  </section>
</template>

<script setup lang="ts">
import type { EdgeType } from '@/auto_generated/graphql'
import { callDivisionEdgeTypesQuery } from '@/call/queries'
import EdgeTypeItemMolecule from '@/components/molecules/EdgeTypeItemMolecule.vue'

const props = defineProps<{
  divisionId: string;
}>()

const emit = defineEmits<{
  (e: 'click:createEdgeType');
  (e: 'click:updateEdgeType', edgeType: EdgeType);
  (e: 'click:createEdgeField', edgeType: EdgeType);
  (e: 'click:createRule', edgeType: EdgeType);
}>()

const { fetching, error, data } = callDivisionEdgeTypesQuery(props.divisionId)
</script>
