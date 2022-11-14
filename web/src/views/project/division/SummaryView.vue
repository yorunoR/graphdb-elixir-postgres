<template>
  <main style="max-width: 768px; margin: auto">
    <section>
      <h1>Summary</h1>
      <div v-if="data">
        <DataTable
          :value="data.division.summary"
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
  </main>
</template>

<script setup lang="ts">
import { callDivisionSummaryQuery } from '@/call/queries'

const props = defineProps<{
  divisionId: string;
}>()

const { data } = callDivisionSummaryQuery(props.divisionId)
</script>
