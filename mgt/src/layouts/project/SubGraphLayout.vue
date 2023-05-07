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
          v-if="data"
          style="height: calc(100% - 96px)"
        >
          <h3>
            {{ $t('subGraph.title') }}
          </h3>
          <div>
            <ProjectMolecule v-bind="data.subGraphFilter?.project" />
            <TowerMolecule
              class="mt-1"
              v-bind="data.subGraphFilter?.tower"
            />
            <DivisionMolecule
              class="mt-1"
              v-bind="data.subGraphFilter?.division"
            />
            <SubGraphMolecule
              class="mt-1"
              v-bind="data.subGraphFilter"
            />
          </div>
          <div
            style="height: calc(100% - 124px)"
            class="overflow-y-scroll"
          >
            <div
              class="pl-3 mt-4 cursor-pointer flex align-items-center"
              @click="visibleToggle = !visibleToggle"
            >
              <span>{{ $t('division.title') }}</span>
              <i
                v-show="!visibleToggle"
                class="ml-2 pi pi-angle-left"
              />
              <i
                v-show="visibleToggle"
                class="ml-2 pi pi-angle-down"
              />
            </div>
            <ul
              v-if="data && data.subGraphFilter"
              v-show="visibleToggle"
              class="pl-3 my-0"
            >
              <li
                class="list"
                style="border: none"
              >
                <router-link
                  :to="{
                    name: 'summary',
                    params: { divisionId: data.subGraphFilter.division.id },
                  }"
                >
                  <span style="white-space: nowrap">{{ $t('division.subGraphFilters') }}</span>
                </router-link>
              </li>
              <li
                class="list"
                style="border: none"
              >
                <router-link
                  :to="{
                    name: 'node_types',
                    params: { divisionId: data.subGraphFilter.division.id },
                  }"
                >
                  {{ $t('division.nodeTypes') }}
                </router-link>
              </li>
              <li
                class="list"
                style="border: none"
              >
                <router-link
                  :to="{
                    name: 'edge_types',
                    params: { divisionId: data.subGraphFilter.division.id },
                  }"
                >
                  {{ $t('division.edgeTypes') }}
                </router-link>
              </li>
              <li
                class="list"
                style="border: none"
              >
                <router-link
                  :to="{ name: 'upload_csv', params: { divisionId: data.subGraphFilter.division.id } }"
                >
                  {{ $t('division.uploadCsv') }}
                </router-link>
              </li>
              <li
                class="list"
                style="border: none"
              >
                <router-link
                  :to="{
                    name: 'nodes',
                    params: { divisionId: data.subGraphFilter.division.id },
                  }"
                >
                  {{ $t('division.nodes') }}
                </router-link>
              </li>
              <li
                class="list"
                style="border: none"
              >
                <router-link
                  :to="{
                    name: 'edges',
                    params: { divisionId: data.subGraphFilter.division.id },
                  }"
                >
                  {{ $t('division.edges') }}
                </router-link>
              </li>
              <li
                class="list"
                style="border: none"
              >
                <router-link
                  :to="{
                    name: 'sub_graph_filters',
                    params: { divisionId: data.subGraphFilter.division.id },
                  }"
                >
                  {{ $t('division.subGraphFilters') }}
                </router-link>
              </li>
            </ul>
            <div class="pl-3 mt-4">
              {{ $t('subGraph.title') }}
            </div>
            <ul class="pl-3 mt-0">
              <li
                class="list"
                style="border: none"
              >
                <router-link
                  :to="{
                    name: 'search',
                    params: { subGraphFilterId },
                  }"
                >
                  {{ $t('subGraph.searchCondition') }}
                </router-link>
              </li>
              <li
                class="list"
                style="border: none"
              >
                <router-link
                  :to="{
                    name: 'status',
                    params: { subGraphFilterId },
                  }"
                >
                  {{ $t('subGraph.control') }}
                </router-link>
              </li>
              <li
                class="list"
                style="border: none"
              >
                <router-link
                  :to="{
                    name: 'results',
                    params: { subGraphFilterId },
                  }"
                >
                  {{ $t('subGraph.results') }}
                </router-link>
              </li>
              <li
                class="list"
                style="border: none"
              >
                <router-link
                  :to="{
                    name: 'diagram',
                    params: { subGraphFilterId },
                  }"
                >
                  {{ $t('subGraph.diagram') }}
                </router-link>
              </li>
            </ul>
            <ul>
              <li
                v-if="data && data.subGraphFilter"
                class="list"
                style="border: none"
              >
                <router-link :to="{ name: 'divisions', params: { towerId: data.subGraphFilter.tower.id}}">
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
          <SubGraphBreadcrumb :subGraphFilter="data.subGraphFilter" />
        </div>
      </div>
    </div>
    <div
      class="p-3"
      style="max-width: 768px; margin: auto"
    >
      <div
        v-if="data && data.subGraphFilter"
        class="mt-8 pt-4"
      >
        <router-view
          :divisionId="data.subGraphFilter.division.id"
          :subGraphFilterId="subGraphFilterId"
        />
      </div>
    </div>
  </q-layout>
</template>

<script setup lang="ts">
import { ref } from 'vue'

import { useSubGraphFilterQuery } from '@/auto_generated/graphql'
import DivisionMolecule from '@/components/molecules/DivisionMolecule.vue'
import ProjectMolecule from '@/components/molecules/ProjectMolecule.vue'
import SubGraphBreadcrumb from '@/components/molecules/SubGraphBreadcrumb.vue'
import SubGraphMolecule from '@/components/molecules/SubGraphMolecule.vue'
import TowerMolecule from '@/components/molecules/TowerMolecule.vue'
import router from '@/router'
import firebase from '@/services/firebase'

const props = defineProps<{
  subGraphFilterId: string;
}>()

const visibleLeft = ref(true)
const visibleToggle = ref(false)
const visibleSwitch = ref(!firebase.currentUser().isAnonymous)

const { data } = useSubGraphFilterQuery({
  variables: { subGraphFilterId: props.subGraphFilterId }
})

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
