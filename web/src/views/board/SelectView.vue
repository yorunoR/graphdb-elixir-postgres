<template>
  <main style="max-width: 768px; margin: auto">
    <h1>Project</h1>
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
      <h2>Create Project</h2>
      <InputText
        v-model="name"
        class="w-full"
        type="text"
        placeholder="Name"
      />
      <Button
        class="mt-3 w-full"
        label="Submit"
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
