<template>
  <Breadcrumb
    class="ml-2 px-2 py-1 text-sm"
    :home="home"
    :model="items"
  />
</template>

<script setup lang="ts">
import { ref } from 'vue'

import type { SubGraphFilter } from '@/auto_generated/graphql'

const props = defineProps<{
  subGraphFilter: SubGraphFilter;
}>()

const home = ref({ icon: 'pi pi-home', to: { name: 'towers' } })
const items = ref([
  { label: props.subGraphFilter.tower.name, to: { name: 'divisions', params: { towerId: props.subGraphFilter.tower.id } } },
  { label: props.subGraphFilter.division.name, to: { name: 'summary', params: { divisionId: props.subGraphFilter.division.id } } },
  { label: props.subGraphFilter.name, to: { name: 'search', params: { subGraphFilterId: props.subGraphFilter.id } } }
])
</script>

<style lang="scss">
.p-menuitem-link {
  padding: 4px;
}

.p-menuitem-text {
  padding-left: 4px;
  padding-right: 4px;
}

a.router-link-active-exact {
  background-color: #dddddd;
}

.p-menuitem-separator {
  margin: 0px 2px !important;
}
</style>
