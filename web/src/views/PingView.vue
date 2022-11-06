<template>
  <main>
    <section>
      <h1>pong</h1>
      <div v-if="fetching">
        Loading...
      </div>
      <div v-else-if="error">
        Oh no... {{ error }}
      </div>
      <div v-else>
        <div v-if="data">
          {{ data.ping.status }}
        </div>
      </div>
    </section>
    <hr>
    <!--section>
      <h1>user</h1>
      <div v-if="userData">
        {{ userData.newUser.name }}
      </div>
    </section-->
  </main>
</template>

<script setup lang="ts">
// import { usePingQuery, useNewUserSubscription } from '@/auto_generated/graphql'
import { usePingQuery } from '@/auto_generated/graphql'

const { fetching, error, data } = usePingQuery()
// const { data: userData } = useNewUserSubscription()
</script>
