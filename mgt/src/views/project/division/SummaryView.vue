<template>
  <main style="max-width: 768px; margin: auto">
    <h1>
      {{ $t('division.subGraphFilters') }}
    </h1>
    <section>
      <div v-if="data">
        <DataTable
          :value="data.division?.summary"
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
      </div>
    </section>
    <section class="mt-4">
      <SubGraphFilterListOrganism
        :division-id="divisionId"
        @click:createSubGraphFilter="() => (visibleRight = true)"
        @click:updateSubGraphFilter="
          (subGraphFilter) => openUpdateSubGraphFilter(subGraphFilter)
        "
      />
    </section>
  </main>
  <Sidebar
    v-model:visible="visibleRight"
    position="right"
  >
    <SubGraphFilterCreateOrganism
      :division-id="divisionId"
      @created="visibleRight = false"
    />
  </Sidebar>
  <Sidebar
    v-model:visible="visibleRight2"
    position="right"
  >
    <SubGraphFilterUpdateOrganism
      :sub-graph-filter="selectedSubGraphFilter"
      @created="visibleRight2 = false"
    />
  </Sidebar>
</template>

<script setup lang="ts">
import { ref } from 'vue'

import { callDivisionSummaryQuery } from '@/call/queries'
import SubGraphFilterCreateOrganism from '@/components/organisms/SubGraphFilterCreateOrganism.vue'
import SubGraphFilterListOrganism from '@/components/organisms/SubGraphFilterListOrganism.vue'
import SubGraphFilterUpdateOrganism from '@/components/organisms/SubGraphFilterUpdateOrganism.vue'

const props = defineProps<{
  divisionId: string;
}>()

const visibleRight = ref(false)
const visibleRight2 = ref(false)
const selectedSubGraphFilter = ref({})

const { data } = callDivisionSummaryQuery(props.divisionId)

const openUpdateSubGraphFilter = (subGraphFilter) => {
  selectedSubGraphFilter.value = subGraphFilter
  visibleRight2.value = true
}
</script>
