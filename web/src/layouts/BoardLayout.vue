<template>
  <Sidebar v-model:visible="visibleLeft">
    <div
      class="h-screen adjust-height flex flex-column justify-content-between"
    >
      <section>
        <h2>Board</h2>
        <ul>
          <li style="border: none">
            <router-link to="/board/select">
              Select
            </router-link>
          </li>
          <li style="border: none">
            <router-link to="/board/about">
              About
            </router-link>
          </li>
        </ul>
      </section>
      <Button @click="signOut">
        Sign Out
      </Button>
    </div>
  </Sidebar>
  <div class="flex flex-row p-3">
    <Button
      icon="pi pi-arrow-right"
      @click="visibleLeft = true"
    />
  </div>
  <div
    v-if="visibleMain"
    class="p-3"
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
