<template>
  <main style="max-width: 768px; margin: auto">
    <h1>
      {{ $t('subGraph.control') }}
    </h1>
    <section>
      <div class="grid">
        <div class="p-3 col-12 md:col-6 lg:col-6 border-round panel-outline">
          <SubGraphControlOrganism
            :subGraphFilterId="subGraphFilterId"
          />
        </div>
        <div class="p-3 col-12 md:col-6 lg:col-6 border-round panel-outline">
          <LibgraphControlOrganism
            :subGraphFilterId="subGraphFilterId"
          />
        </div>
      </div>
    </section>
  </main>
</template>

<script setup lang="ts">
import LibgraphControlOrganism from '@/components/organisms/LibgraphControlOrganism.vue'
import SubGraphControlOrganism from '@/components/organisms/SubGraphControlOrganism.vue'

defineProps<{
  divisionId: string;
  subGraphFilterId: string;
}>()
</script>
