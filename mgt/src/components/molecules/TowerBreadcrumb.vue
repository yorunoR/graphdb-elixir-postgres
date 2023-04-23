<template>
  <Breadcrumb
    class="ml-2 px-2 py-1 text-sm"
    :home="home"
    :model="items"
  />
</template>

<script setup lang="ts">
import { ref } from 'vue'

import type { Tower } from '@/auto_generated/graphql'

const props = defineProps<{
  tower: Tower;
}>()

const home = ref({ icon: 'pi pi-home', to: { name: 'towers' } })
const items = ref([
  { label: props.tower.name, to: { name: 'divisions' } }
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
