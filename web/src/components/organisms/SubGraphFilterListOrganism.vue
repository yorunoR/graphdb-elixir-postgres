<template>
  <section>
    <Button
      class="w-full"
      :label="$t('common.create')"
      @click="() => emit('click:createSubGraphFilter')"
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
      <ul v-if="data && data.division">
        <li
          v-for="subGraphFilter in data.division.subGraphFilters"
          :key="subGraphFilter.id"
          class="list"
        >
          <SubGraphFilterItemMolecule
            :division-id="divisionId"
            :sub-graph-filter="subGraphFilter"
            @click:updateSubGraphFilter="
              () => emit('click:updateSubGraphFilter', subGraphFilter)
            "
          />
        </li>
      </ul>
    </div>
  </section>
</template>

<script setup lang="ts">
import { useDivisionSubGraphFiltersQuery } from '@/auto_generated/graphql'
import type { SubGraphFilter } from '@/auto_generated/graphql'
import SubGraphFilterItemMolecule from '@/components/molecules/SubGraphFilterItemMolecule.vue'

const props = defineProps<{
  divisionId: string;
}>()

const emit = defineEmits<{
  (e: 'click:createSubGraphFilter');
  (e: 'click:updateSubGraphFilter', subGraphFilter: SubGraphFilter);
}>()

const { fetching, error, data } = useDivisionSubGraphFiltersQuery({
  variables: { divisionId: props.divisionId },
  context: { additionalTypenames: ['SubGraphFilter'] }
})
</script>
