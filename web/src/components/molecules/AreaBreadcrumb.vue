<template>
  <Breadcrumb
    class="ml-2 px-2 py-1 text-sm"
    :home="home"
  />
</template>

<script setup lang="ts">
import { ref } from 'vue'

import type { Project } from '@/auto_generated/graphql'

defineProps<{
  project: Project;
}>()

const home = ref({ icon: 'pi pi-home', to: { name: 'towers' } })
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
</style>
