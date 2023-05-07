<template>
  <q-layout>
    <q-drawer
      v-model="visibleLeft"
      :breakpoint="1380"
      :width="320"
      overlay
      persistent
      style="border-right: 1px solid #eeeeee"
    >
      <div class="text-left pt-3 pl-3">
        <Button
          icon="pi pi-arrow-left"
          @click="visibleLeft = false"
        />
      </div>
      <div
        class="flex flex-column justify-content-between text-left px-3 pb-3"
        style="height: calc(100vh - 58px)"
      >
        <section
          style="height: calc(100% - 72px)"
        >
          <h3>
            {{ $t('division.title') }}
          </h3>
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
                    >
                      <span style="white-space: nowrap">{{ $t('division.subGraphFilters') }}</span>
                    </router-link>
                  </li>
                  <li
                    class="list"
                    style="border: none"
                  >
                    <router-link
                      :to="{ name: 'node_types', params: { divisionId } }"
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
                    >
                      {{ $t('division.edges') }}
                    </router-link>
                  </li>
                  <!--li
                    class="list"
                    style="border: none"
                  >
                    <router-link
                      :to="{ name: 'sub_graph_filters', params: { divisionId } }"
                    >
                      {{ $t('division.subGraphFilters') }}
                    </router-link>
                  </li-->
                </ul>
              </li>
            </ul>
            <ul>
              <li
                v-if="data"
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
                v-if="visibleSwitch"
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
    </q-drawer>
    <div class="fixed top-0 flex flex-row p-3 w-full z-2">
      <div class="flex-none">
        <Button
          icon="pi pi-arrow-right"
          @click="visibleLeft = true"
        />
      </div>
    </div>
    <div class="fixed top-0 w-full z-1 bg-white">
      <div
        class="p-3 flex"
        style="max-width: 768px; margin: auto"
      >
        <div
          v-if="data"
          class="flex-grow-1 mt-6"
        >
          <DivisionBreadcrumb :division="data.division" />
        </div>
      </div>
    </div>
    <div
      class="p-3"
      style="max-width: 768px; margin: auto"
    >
      <div class="mt-8 pt-4">
        <router-view :division-id="divisionId" />
      </div>
    </div>
  </q-layout>
</template>

<script setup lang="ts">
import { ref } from 'vue'

import { callDivisionSummaryQuery } from '@/call/queries'
import DivisionBreadcrumb from '@/components/molecules/DivisionBreadcrumb.vue'
import DivisionMolecule from '@/components/molecules/DivisionMolecule.vue'
import ProjectMolecule from '@/components/molecules/ProjectMolecule.vue'
import TowerMolecule from '@/components/molecules/TowerMolecule.vue'
import router from '@/router'
import firebase from '@/services/firebase'

const props = defineProps<{
  divisionId: string;
}>()

const visibleLeft = ref(true)
const visibleSwitch = ref(!firebase.currentUser().isAnonymous)

const { data } = callDivisionSummaryQuery(props.divisionId)

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
