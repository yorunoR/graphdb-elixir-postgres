<template>
  <div v-if="visibleMain">
    <router-view />
  </div>
  <Toast />
</template>

<script setup lang="ts">
import { provideClient } from '@urql/vue'
import { ref } from 'vue'

import router from '@/router'
import { makeClient } from '@/services/client'
import firebase from '@/services/firebase'

const visibleMain = ref(false)

firebase.onAuthStateChanged((user) => {
  if (user) {
    visibleMain.value = true
  } else {
    router.push({ name: 'sign_in' })
  }
})

provideClient(makeClient())
</script>
