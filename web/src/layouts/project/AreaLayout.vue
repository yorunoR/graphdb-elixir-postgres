<template>
  <Sidebar v-model:visible="visibleLeft">
    <div
      class="h-screen adjust-height flex flex-column justify-content-between"
    >
      <section>
        <h2>
          {{ $t("project.title") }}
        </h2>
        <div v-if="data">
          <ProjectMolecule v-bind="data.currentProject" />
        </div>
        <ul>
          <li
            class="list"
            style="border: none"
          >
            <router-link :to="{ name: 'towers' }">
              {{ $t("project.towers") }}
            </router-link>
          </li>
          <li
            class="list"
            style="border: none"
          >
            <router-link :to="{ name: 'keys' }">
              {{ $t("project.apiKeys") }}
            </router-link>
          </li>
          <li
            class="list"
            style="border: none"
          >
            <router-link :to="{ name: 'info' }">
              {{ $t("project.information") }}
            </router-link>
          </li>
          <li
            class="list"
            style="border: none"
          >
            <router-link :to="{ name: 'select' }">
              {{ $t("board.switch") }}
            </router-link>
          </li>
        </ul>
      </section>
      <Button @click="signOut">
        {{ $t("account.signOut") }}
      </Button>
    </div>
  </Sidebar>
  <div class="fixed top-0 flex flex-row p-3 w-full z-1">
    <div class="flex-none">
      <Button
        icon="pi pi-arrow-right"
        @click="visibleLeft = true"
      />
    </div>
    <div
      v-if="data"
      class="flex-grow-1"
    >
      <AreaBreadcrumb :project="data.currentProject" />
    </div>
  </div>
  <div class="pt-8 px-3 pb-3">
    <router-view />
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'

import {
  useProjectTowersQuery
} from '@/auto_generated/graphql'
import AreaBreadcrumb from '@/components/molecules/AreaBreadcrumb.vue'
import ProjectMolecule from '@/components/molecules/ProjectMolecule.vue'
import router from '@/router'
import firebase from '@/services/firebase'

const visibleLeft = ref(false)

const { data } = useProjectTowersQuery({
  context: { additionalTypenames: ['Tower'] }
})

const signOut = async () => {
  await firebase.signout()
  router.push({ name: 'sign_in' })
}
</script>

<style lang="scss">
.adjust-height {
  margin-top: -80px;
  padding-top: 80px;
}
</style>
