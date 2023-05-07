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
            {{ $t('tower.title') }}
          </h3>
          <div v-if="data">
            <ProjectMolecule v-bind="data.tower?.project" />
            <TowerMolecule
              class="mt-1"
              v-bind="data.tower"
            />
          </div>
          <ul>
            <li
              class="list"
              style="border: none"
            >
              <router-link :to="{ name: 'divisions' }">
                {{ $t('tower.divisions') }}
              </router-link>
            </li>
            <li
              class="list"
              style="border: none"
            >
              <router-link :to="{ name: 'setting' }">
                {{ $t('tower.setting') }}
              </router-link>
            </li>
            <li
              class="list"
              style="border: none"
            >
              <router-link :to="{ name: 'towers' }">
                {{ $t('tower.return') }}
              </router-link>
            </li>
            <li
              v-if="visibleSwitch"
              class="list"
              style="border: none"
            >
              <router-link :to="{ name: 'select' }">
                {{ $t('board.switch') }}
              </router-link>
            </li>
          </ul>
        </section>
        <Button @click="signOut">
          {{ $t('account.signOut') }}
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
          <TowerBreadcrumb :tower="data.tower" />
        </div>
      </div>
    </div>
    <div
      class="p-3"
      style="max-width: 768px; margin: auto"
    >
      <div class="mt-8 pt-4">
        <router-view :tower-id="towerId" />
      </div>
    </div>
  </q-layout>
</template>

<script setup lang="ts">
import { ref } from 'vue'

import {
  useTowerDivisionsQuery
} from '@/auto_generated/graphql'
import ProjectMolecule from '@/components/molecules/ProjectMolecule.vue'
import TowerBreadcrumb from '@/components/molecules/TowerBreadcrumb.vue'
import TowerMolecule from '@/components/molecules/TowerMolecule.vue'
import router from '@/router'
import firebase from '@/services/firebase'

const props = defineProps<{
  towerId: string;
}>()

const visibleLeft = ref(true)
const visibleSwitch = ref(!firebase.currentUser().isAnonymous)

const { data } = useTowerDivisionsQuery({
  variables: { towerId: props.towerId },
  context: { additionalTypenames: ['Division'] }
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
