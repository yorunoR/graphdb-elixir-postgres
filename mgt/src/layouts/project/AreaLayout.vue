<template>
  <q-layout>
    <q-drawer
      v-model="visibleLeft"
      :breakpoint="1380"
      :width="320"
      overlay
      persistent
      style="border-right: 1px solid #eeeeee"
    >
      <div class="text-left pt-3 pl-3">
        <Button
          icon="pi pi-arrow-left"
          @click="visibleLeft = false"
        />
      </div>
      <div
        class="flex flex-column justify-content-between text-left px-3 pb-3"
        style="height: calc(100vh - 58px)"
      >
        <section>
          <h3>
            {{ $t("project.title") }}
          </h3>
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
              v-if="visibleSwitch"
              class="list"
              style="border: none"
            >
              <router-link :to="{ name: 'info' }">
                {{ $t("project.information") }}
              </router-link>
            </li>
            <li
              v-if="visibleSwitch"
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
    </q-drawer>
    <div class="fixed top-0 flex flex-row p-3 w-full z-2">
      <div class="flex-none">
        <Button
          icon="pi pi-arrow-right"
          @click="visibleLeft = true"
        />
      </div>
    </div>
    <div class="fixed top-0 w-full z-1 bg-white">
      <div
        class="p-3 flex"
        style="max-width: 768px; margin: auto"
      >
        <div
          v-if="data"
          class="flex-grow-1 mt-6"
        >
          <AreaBreadcrumb :project="data.currentProject" />
        </div>
      </div>
    </div>
    <div
      class="p-3"
      style="max-width: 768px; margin: auto"
    >
      <div class="mt-8 pt-4">
        <router-view />
      </div>
    </div>
  </q-layout>
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

const visibleLeft = ref(true)
const visibleSwitch = ref(!firebase.currentUser().isAnonymous)

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
