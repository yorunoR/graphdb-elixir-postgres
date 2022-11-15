<template>
  <Sidebar v-model:visible="visibleLeft">
    <div
      class="h-screen adjust-height flex flex-column justify-content-between"
    >
      <section v-if="data">
        <h2>SubGraph</h2>
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
          class="pl-3 mt-4 cursor-pointer"
          @click="visibleToggle = !visibleToggle"
        >
          <span>Division </span>
          <i
            v-show="!visibleToggle"
            class="pi pi-plus"
          />
          <i
            v-show="visibleToggle"
            class="pi pi-minus"
          />
        </div>
        <ul
          v-if="data && data.subGraphFilter"
          v-show="visibleToggle"
          class="pl-3 mt-0"
        >
          <li style="border: none">
            <router-link
              :to="{
                name: 'summary',
                params: { divisionId: data.subGraphFilter.division.id },
              }"
              @click="() => close()"
            >
              Summary
            </router-link>
          </li>
          <li style="border: none">
            <router-link
              :to="{
                name: 'node_types',
                params: { divisionId: data.subGraphFilter.division.id },
              }"
              @click="() => close()"
            >
              NodeTypes
            </router-link>
          </li>
          <li style="border: none">
            <router-link
              :to="{
                name: 'edge_types',
                params: { divisionId: data.subGraphFilter.division.id },
              }"
              @click="() => close()"
            >
              EdgeTypes
            </router-link>
          </li>
          <li style="border: none">
            <router-link
              :to="{
                name: 'nodes',
                params: { divisionId: data.subGraphFilter.division.id },
              }"
              @click="() => close()"
            >
              Nodes
            </router-link>
          </li>
          <li style="border: none">
            <router-link
              :to="{
                name: 'edges',
                params: { divisionId: data.subGraphFilter.division.id },
              }"
              @click="() => close()"
            >
              Edges
            </router-link>
          </li>
          <li style="border: none">
            <router-link
              :to="{
                name: 'sub_graph_filters',
                params: { divisionId: data.subGraphFilter.division.id },
              }"
            >
              SubGraphFilters
            </router-link>
          </li>
        </ul>
        <div class="pl-3 mt-4">
          SubGraph
        </div>
        <ul class="pl-3 mt-0">
          <li style="border: none">
            <router-link
              :to="{
                name: 'search',
                params: { subGraphFilterId },
              }"
              @click="() => close()"
            >
              Search
            </router-link>
          </li>
        </ul>
        <ul>
          <li
            class="mt-1"
            style="border: none"
          >
            <router-link to="/board/select">
              Return Board
            </router-link>
          </li>
        </ul>
      </section>
      <Button @click="signOut">
        Sign Out
      </Button>
    </div>
  </Sidebar>
  <div class="flex flex-row p-3">
    <Button
      icon="pi pi-arrow-right"
      @click="visibleLeft = true"
    />
  </div>
  <div class="p-3">
    <router-view :sub-graph-filter-id="subGraphFilterId" />
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'

import { useSubGraphFilterQuery } from '@/auto_generated/graphql'
import DivisionMolecule from '@/components/molecules/DivisionMolecule.vue'
import ProjectMolecule from '@/components/molecules/ProjectMolecule.vue'
import SubGraphMolecule from '@/components/molecules/SubGraphMolecule.vue'
import TowerMolecule from '@/components/molecules/TowerMolecule.vue'
import router from '@/router'
import firebase from '@/services/firebase'

const props = defineProps<{
  subGraphFilterId: string;
}>()

const visibleLeft = ref(false)
const visibleToggle = ref(false)

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
