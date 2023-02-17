<template>
  <main style="max-width: 768px; margin: auto">
    <h1>
      {{ $t("project.towers") }}
    </h1>
    <section>
      <Button
        class="w-full"
        :label="$t('common.create')"
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
            v-for="tower in data.currentProject?.towers"
            :key="tower.id"
            class="list"
          >
            <div class="flex justify-content-between align-items-center">
              <strong>{{ tower.name }}</strong>
              <div style="cursor: pointer">
                <i
                  class="pi pi-sign-in"
                  @click="(_event) => moveToTower(tower.id)"
                />
              </div>
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
      <h2>
        {{ $t('tower.create') }}
      </h2>
      <InputText
        v-model="name"
        class="w-full"
        type="text"
        :placeholder="$t('common.name')"
      />
      <Button
        class="mt-3 w-full"
        :label="$t('common.submit')"
        @click="clickCreateTower"
      />
    </section>
  </Sidebar>
</template>

<script setup lang="ts">
import { useToast } from 'primevue/usetoast'
import { ref } from 'vue'

import {
  useProjectTowersQuery,
  useCreateTowerMutation
} from '@/auto_generated/graphql'
import router from '@/router'

const toast = useToast()

const { executeMutation: createTower } = useCreateTowerMutation()

const visibleRight = ref(false)
const name = ref('')

const { fetching, error, data } = useProjectTowersQuery({
  context: { additionalTypenames: ['Tower'] }
})

const clickCreateTower = async () => {
  const result = await createTower({
    tower: { name: name.value }
  })
  visibleRight.value = false
  if (result.error) {
    toast.add({
      severity: 'error',
      summary: 'Create tower',
      detail: result.error.message
    })
  }
}

const moveToTower = (towerId) => {
  router.push({ name: 'divisions', params: { towerId } })
}
</script>
