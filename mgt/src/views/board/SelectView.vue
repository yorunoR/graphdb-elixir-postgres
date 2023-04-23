<template>
  <main style="max-width: 768px; margin: auto">
    <h1>
      {{ $t("board.projects") }}
    </h1>
    <section>
      <Button
        class="w-full p-button-secondary"
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
            v-for="project in data.currentUser.projects"
            :key="project.id"
            class="list"
          >
            <div class="flex justify-content-between align-items-center">
              <strong>{{ project.name }}</strong>
              <span>
                <i class="pi pi-key" />
                <strong class="ml-2">{{ project.projectKey }}</strong>
              </span>
              <div style="cursor: pointer">
                <i
                  class="pi pi-sign-in"
                  @click="(_event) => moveToProject(project.id)"
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
        {{ $t('project.create') }}
      </h2>
      <InputText
        v-model="name"
        class="w-full"
        type="text"
        :placeholder="$t('common.name')"
      />
      <Button
        class="mt-3 w-full p-button-secondary"
        :label="$t('common.submit')"
        @click="clickCreateProject"
      />
    </section>
  </Sidebar>
</template>

<script setup lang="ts">
import { ref } from 'vue'

import {
  useUserProjectsQuery,
  useCreateProjectMutation
} from '@/auto_generated/graphql'
import router from '@/router'
import storage from '@/services/storage'

const { executeMutation: createProject } = useCreateProjectMutation()

const visibleRight = ref(false)
const name = ref('')

const { fetching, error, data } = useUserProjectsQuery()

const clickCreateProject = async () => {
  await createProject({
    project: { name: name.value }
  })
  visibleRight.value = false
}

const moveToProject = (projectId) => {
  storage.setCid(projectId)
  router.push({ name: 'towers' })
}
</script>
