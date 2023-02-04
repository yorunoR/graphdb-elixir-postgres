<template>
  <main style="max-width: 768px; margin: auto">
    <h1>Result</h1>
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
            v-for="result in data.subGraphFilter.results"
            :key="result.id"
            class="list"
          >
            <div class="flex justify-content-between align-items-center">
              <span>Name: <strong>{{ result.name }}</strong></span>
              <span>Command: {{ result.algorithm.name }}{{ result.args }}</span>
            </div>
            <div class="mt-2 flex justify-content-end align-items-center">
              <span>OpenedAt: {{ result.openedAt }}</span>
            </div>
            <ul class="mt-2 p-2 flex flex-column justify-content-start align-items-center">
              <li
                v-for="item in result.props"
                :key="item.key"
                class="list w-full"
              >
                <span>{{ item.key }}: {{ item.val }}</span>
              </li>
            </ul>
          </li>
        </ul>
      </div>
    </section>
  </main>
</template>

<script setup lang="ts">
import { useSubGraphFilterResultsQuery } from '@/auto_generated/graphql'

const props = defineProps<{
  divisionId: string;
  subGraphFilterId: string;
}>()

const { fetching, error, data } = useSubGraphFilterResultsQuery({
  variables: { subGraphFilterId: props.subGraphFilterId },
  context: { additionalTypenames: ['Result'] }
})
</script>
