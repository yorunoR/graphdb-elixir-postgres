<template>
  <Sidebar v-model:visible="visibleLeft">
    <div
      class="h-screen adjust-height flex flex-column justify-content-between"
    >
      <section>
        <h2>
          {{ $t("board.title") }}
        </h2>
        <ul>
          <li
            class="list"
            style="border: none"
          >
            <router-link to="/board/select">
              {{ $t("board.projects") }}
            </router-link>
          </li>
          <li
            class="list"
            style="border: none"
          >
            <router-link to="/board/about">
              {{ $t("board.about") }}
            </router-link>
          </li>
        </ul>
      </section>
      <Button @click="signOut">
        {{ $t("account.signOut") }}
      </Button>
    </div>
  </Sidebar>
  <div class="fixed top-0 flex flex-row p-3">
    <Button
      icon="pi pi-arrow-right"
      @click="visibleLeft = true"
    />
  </div>
  <div
    v-if="visibleMain"
    class="pt-6 px-3 pb-3"
  >
    <router-view />
  </div>
  <Toast :breakpoints="{'576px': {width: '97%', left: '6px'}}" />
</template>

<script setup lang="ts">
import { provideClient } from '@urql/vue'
import { ref } from 'vue'

import router from '@/router'
import { makeClient } from '@/services/client'
import firebase from '@/services/firebase'

const visibleMain = ref(false)
const visibleLeft = ref(false)

firebase.onAuthStateChanged((user) => {
  if (user) {
    visibleMain.value = true
  } else {
    router.push({ name: 'sign_in' })
  }
})

provideClient(makeClient())

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
