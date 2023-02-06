<template>
  <Sidebar v-model:visible="visibleLeft">
    <div
      class="h-screen adjust-height flex flex-column justify-content-between"
    >
      <section>
        <h2>
          {{ $t('tower.title') }}
        </h2>
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
  </Sidebar>
  <div class="fixed top-0 flex flex-row p-3">
    <Button
      icon="pi pi-arrow-right"
      @click="visibleLeft = true"
    />
  </div>
  <div class="pt-6 px-3 pb-3">
    <router-view :tower-id="towerId" />
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'

import {
  useTowerDivisionsQuery
} from '@/auto_generated/graphql'
import ProjectMolecule from '@/components/molecules/ProjectMolecule.vue'
import TowerMolecule from '@/components/molecules/TowerMolecule.vue'
import router from '@/router'
import firebase from '@/services/firebase'

const props = defineProps<{
  towerId: string;
}>()

const visibleLeft = ref(false)

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
