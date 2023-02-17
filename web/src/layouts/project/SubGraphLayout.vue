<template>
  <Sidebar v-model:visible="visibleLeft">
    <div
      class="h-screen adjust-height flex flex-column justify-content-between"
    >
      <section
        style="height: calc(100% - 96px)"
      >
        <h2>
          {{ $t('subGraph.title') }}
        </h2>
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
                @click="() => close()"
              >
                <span style="white-space: nowrap">{{ $t('division.summary') }} / {{ $t('division.subGraphFilters') }}</span>
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
                :to="{
                  name: 'edge_types',
                  params: { divisionId: data.subGraphFilter.division.id },
                }"
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
                :to="{ name: 'upload_csv', params: { divisionId: data.subGraphFilter.division.id } }"
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
                :to="{
                  name: 'nodes',
                  params: { divisionId: data.subGraphFilter.division.id },
                }"
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
                :to="{
                  name: 'edges',
                  params: { divisionId: data.subGraphFilter.division.id },
                }"
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
                @click="() => close()"
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
                @click="() => close()"
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
                @click="() => close()"
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
                @click="() => close()"
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
  </Sidebar>
  <div class="fixed top-0 flex flex-row p-3 w-full z-1">
    <div class="flex-none">
      <Button
        icon="pi pi-arrow-right"
        @click="visibleLeft = true"
      />
    </div>
    <div
      v-if="data"
      class="flex-grow-1"
    >
      <SubGraphBreadcrumb :subGraphFilter="data.subGraphFilter" />
    </div>
  </div>
  <div
    v-if="data && data.subGraphFilter"
    class="pt-8 px-3 pb-3"
  >
    <router-view
      :divisionId="data.subGraphFilter.division.id"
      :subGraphFilterId="subGraphFilterId"
    />
  </div>
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

const visibleLeft = ref(false)
const visibleToggle = ref(false)
const visibleSwitch = ref(!firebase.currentUser().isAnonymous)

const { data } = useSubGraphFilterQuery({
  variables: { subGraphFilterId: props.subGraphFilterId }
})

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
