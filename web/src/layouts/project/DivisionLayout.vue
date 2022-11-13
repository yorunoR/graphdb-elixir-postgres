<template>
  <Sidebar v-model:visible="visibleLeft">
    <div
      class="h-screen adjust-height flex flex-column justify-content-between"
    >
      <section>
        <h2>Division</h2>
        <div v-if="data">
          <ProjectMolecule v-bind="data.division.project" />
          <TowerMolecule
            class="mt-1"
            v-bind="data.division.tower"
          />
          <DivisionMolecule
            class="mt-1"
            v-bind="data.division"
          />
        </div>
        <ul>
          <li style="border: none">
            <router-link :to="{ name: 'towers' }">
              Towers
            </router-link>
          </li>
          <li style="border: none">
            <router-link :to="{ name: 'divisions', params: { towerId: data.division.tower.id}}">
              Divisions
            </router-link>
          </li>
          <li style="border: none">
            <div>Division</div>
            <ul class="mt-3">
              <li style="border: none">
                <router-link
                  :to="{ name: 'summary', params: { divisionId } }"
                  @click="() => close()"
                >
                  Summary
                </router-link>
              </li>
              <li style="border: none">
                <router-link
                  :to="{ name: 'node_types', params: { divisionId } }"
                  @click="() => close()"
                >
                  NodeTypes
                </router-link>
              </li>
              <!--
              <li style="border: none">
                <router-link
                  :to="{ name: 'edge_types', params: { divisionId } }"
                  @click="() => close()"
                >
                  EdgeTypes
                </router-link>
              </li>
              <li style="border: none">
                <router-link
                  :to="{ name: 'nodes', params: { divisionId } }"
                  @click="() => close()"
                >
                  Nodes
                </router-link>
              </li>
              <li style="border: none">
                <router-link
                  :to="{ name: 'edges', params: { divisionId } }"
                  @click="() => close()"
                >
                  Edges
                </router-link>
              </li>
              <li style="border: none">
                <router-link
                  :to="{ name: 'sub_graph_filters', params: { divisionId } }"
                  @click="() => close()"
                >
                  SubGraphFilters
                </router-link>
              </li>
              <li style="border: none">
                <router-link
                  :to="{ name: 'upload_csv', params: { divisionId } }"
                  @click="() => close()"
                >
                  Upload CSV
                </router-link>
              </li>
              -->
            </ul>
          </li>
          <li style="border: none">
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
    <router-view :division-id="divisionId" />
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'

import { useDivisionSummaryQuery } from '@/auto_generated/graphql'
import DivisionMolecule from '@/components/molecules/DivisionMolecule.vue'
import ProjectMolecule from '@/components/molecules/ProjectMolecule.vue'
import TowerMolecule from '@/components/molecules/TowerMolecule.vue'
import router from '@/router'
import firebase from '@/services/firebase'

const props = defineProps<{
  divisionId: string;
}>()

const visibleLeft = ref(false)

const { data } = useDivisionSummaryQuery({
  variables: {
    divisionId: props.divisionId,
    selections: [
      'nodeTypeCount',
      'edgeTypeCount',
      'nodeCount',
      'edgeCount'
    ]
  }
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
