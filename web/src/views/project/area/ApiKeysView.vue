<template>
  <main style="max-width: 768px; margin: auto">
    <h1>Api Key</h1>
    <section>
      <Button
        class="w-full"
        label="Create"
        @click="visibleRight = true"
      />
    </section>
    <section>
      <div
        v-if="fetching"
        class="mt-4"
      >
        Loading...
      </div>
      <div
        v-else-if="error"
        class="mt-4"
      >
        Oh no... {{ error }}
      </div>
      <div v-else>
        <ul v-if="data">
          <li
            v-for="apiKey in data.currentProject?.apiKeys"
            :key="apiKey.id"
            class="list"
          >
            <div class="flex justify-content-between align-items-center">
              <span>NAME:  <strong>{{ apiKey.name }}</strong></span>
              <span>KEY:  <strong>{{ 'mildeaw_' + apiKey.shortToken + '_****************' }}</strong></span>
            </div>
          </li>
        </ul>
      </div>
    </section>
  </main>
  <Sidebar
    v-model:visible="visibleRight"
    position="right"
  >
    <section>
      <h2>Create Api Key</h2>
      <InputText
        v-model="name"
        class="w-full"
        type="text"
        placeholder="Name"
      />
      <Button
        class="mt-3 w-full"
        label="Submit"
        @click="clickCreateApiKey"
      />
    </section>
  </Sidebar>
</template>

<script setup lang="ts">
import { useToast } from 'primevue/usetoast'
import { ref } from 'vue'

import {
  useProjectApiKeysQuery,
  useCreateApiKeyMutation
} from '@/auto_generated/graphql'

const toast = useToast()

const { executeMutation: createApiKey } = useCreateApiKeyMutation()

const visibleRight = ref(false)
const name = ref('')

const { fetching, error, data } = useProjectApiKeysQuery({
  context: { additionalTypenames: ['ApiKey'] }
})

const clickCreateApiKey = async () => {
  const result = await createApiKey({
    apiKey: { name: name.value }
  })
  visibleRight.value = false
  if (result.error) {
    toast.add({
      severity: 'error',
      summary: 'Create api key',
      detail: result.error.message
    })
  }
}
</script>
