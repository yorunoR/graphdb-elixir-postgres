<template>
  <Sidebar v-model:visible="visibleLeft">
    <div
      class="h-screen adjust-height flex flex-column justify-content-between"
    >
      <section
        style="height: calc(100% - 72px)"
      >
        <h2>
          {{ $t('division.title') }}
        </h2>
        <div v-if="data">
          <ProjectMolecule v-bind="data.division?.project" />
          <TowerMolecule
            class="mt-1"
            v-bind="data.division?.tower"
          />
          <DivisionMolecule
            class="mt-1"
            v-bind="data.division"
          />
        </div>
        <div
          style="height: calc(100% - 124px)"
          class="overflow-y-scroll"
        >
          <ul>
            <li
              class="mt-3 py-0 list"
              style="border: none"
            >
              <div>
                {{ $t('division.title') }}
              </div>
              <ul class="my-0">
                <li
                  class="list"
                  style="border: none"
                >
                  <router-link
                    :to="{ name: 'summary', params: { divisionId } }"
                    @click="() => close()"
                  >
                    {{ $t('division.summary') }}
                  </router-link>
                </li>
                <li
                  class="list"
                  style="border: none"
                >
                  <router-link
                    :to="{ name: 'node_types', params: { divisionId } }"
                    @click="() => close()"
                  >
                    {{ $t('division.nodeTypes') }}
                  </router-link>
                </li>
                <li
                  class="list"
                  style="border: none"
                >
                  <router-link
                    :to="{ name: 'edge_types', params: { divisionId } }"
                    @click="() => close()"
                  >
                    {{ $t('division.edgeTypes') }}
                  </router-link>
                </li>
                <li
                  class="list"
                  style="border: none"
                >
                  <router-link
                    :to="{ name: 'upload_csv', params: { divisionId } }"
                    @click="() => close()"
                  >
                    {{ $t('division.uploadCsv') }}
                  </router-link>
                </li>
                <li
                  class="list"
                  style="border: none"
                >
                  <router-link
                    :to="{ name: 'nodes', params: { divisionId } }"
                    @click="() => close()"
                  >
                    {{ $t('division.nodes') }}
                  </router-link>
                </li>
                <li
                  class="list"
                  style="border: none"
                >
                  <router-link
                    :to="{ name: 'edges', params: { divisionId } }"
                    @click="() => close()"
                  >
                    {{ $t('division.edges') }}
                  </router-link>
                </li>
                <li
                  class="list"
                  style="border: none"
                >
                  <router-link
                    :to="{ name: 'sub_graph_filters', params: { divisionId } }"
                    @click="() => close()"
                  >
                    {{ $t('division.subGraphFilters') }}
                  </router-link>
                </li>
              </ul>
            </li>
          </ul>
          <ul>
            <li
              v-if="data.division"
              class="list"
              style="border: none"
            >
              <router-link :to="{ name: 'divisions', params: { towerId: data.division.tower.id}}">
                {{ $t('division.return') }}
              </router-link>
            </li>
            <li
              class="list"
              style="border: none"
            >
              <router-link :to="{ name: 'towers' }">
                {{ $t('tower.return') }}
              </router-link>
            </li>
            <li
              class="list"
              style="border: none"
            >
              <router-link to="/board/select">
                {{ $t('board.switch') }}
              </router-link>
            </li>
          </ul>
        </div>
      </section>
      <Button @click="signOut">
        {{ $t('account.signOut') }}
      </Button>
    </div>
  </Sidebar>
  <div class="fixed top-0 flex flex-row p-3">
    <Button
      icon="pi pi-arrow-right"
      @click="visibleLeft = true"
    />
  </div>
  <div class="pt-6 px-3 pb-3">
    <router-view :division-id="divisionId" />
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'

import { callDivisionSummaryQuery } from '@/call/queries'
import DivisionMolecule from '@/components/molecules/DivisionMolecule.vue'
import ProjectMolecule from '@/components/molecules/ProjectMolecule.vue'
import TowerMolecule from '@/components/molecules/TowerMolecule.vue'
import router from '@/router'
import firebase from '@/services/firebase'

const props = defineProps<{
  divisionId: string;
}>()

const visibleLeft = ref(false)

const { data } = callDivisionSummaryQuery(props.divisionId)

const signOut = async () => {
  await firebase.signout()
  router.push({ name: 'sign_in' })
}

const close = () => {
  visibleLeft.value = false
}
</script>

<style lang="scss">
.adjust-height {
  margin-top: -80px;
  padding-top: 80px;
}
</style>
