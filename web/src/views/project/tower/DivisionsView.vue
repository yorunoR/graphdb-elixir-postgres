<template>
  <main style="max-width: 768px; margin: auto">
    <h1>Division</h1>
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
      <ul v-else-if="data && data.tower">
        <li
          v-for="division in data.tower.divisions.entries"
          :key="division.id"
          class="list"
        >
          <div class="flex justify-content-between align-items-center">
            <strong>{{ division.name }}</strong>
            <div style="cursor: pointer">
              <i
                class="pi pi-sign-in"
                @click="(_event) => moveToDivision(division.id)"
              />
            </div>
          </div>
        </li>
      </ul>
      <Paginator
        :rows="variables.limit"
        :total-records="data && data.tower ? data.tower.divisions.total : 0"
        @page="onPage($event)"
      />
    </section>
  </main>
  <Sidebar
    v-model:visible="visibleRight"
    position="right"
  >
    <section>
      <h2>Create Division</h2>
      <InputText
        v-model="name"
        class="w-full"
        type="text"
        placeholder="Name"
      />
      <Button
        class="mt-3 w-full"
        label="Submit"
        @click="clickCreateDivision"
      />
    </section>
  </Sidebar>
</template>

<script setup lang="ts">
import { useToast } from 'primevue/usetoast'
import { ref } from 'vue'

import {
  useTowerDivisionsQuery,
  useCreateDivisionMutation
} from '@/auto_generated/graphql'
import router from '@/router'

const props = defineProps<{
  towerId: string;
}>()

const toast = useToast()

const { executeMutation: createDivision } = useCreateDivisionMutation()

const visibleRight = ref(false)
const name = ref('')
const variables = ref({
  towerId: props.towerId,
  offset: 0,
  limit: 10
})

const { fetching, error, data } = useTowerDivisionsQuery({
  variables,
  context: { additionalTypenames: ['Division'] }
})

const clickCreateDivision = async () => {
  const result = await createDivision({
    towerId: props.towerId,
    division: { name: name.value }
  })
  visibleRight.value = false
  if (result.error) {
    toast.add({
      severity: 'error',
      summary: 'Create division',
      detail: result.error.message
    })
  }
}

const moveToDivision = (divisionId) => {
  router.push({ name: 'summary', params: { divisionId } })
}

const onPage = (event) => {
  variables.value.offset = event.first
}
</script>

<style lang="scss">
.adjust-height {
  margin-top: -80px;
  padding-top: 80px;
}
</style>
