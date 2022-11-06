<template>
  <router-view />
  <Toast />
</template>

<script setup lang="ts">
import { provideClient } from '@urql/vue'

import { makeClient } from '@/services/client'

provideClient(makeClient())
</script>
