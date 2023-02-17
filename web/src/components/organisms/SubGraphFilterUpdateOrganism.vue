<template>
  <section>
    <h2>
      {{ $t('subGraphFilter.update') }}
    </h2>
    <SubGraphFilterFormMolecule
      v-bind="subGraphFilter"
      @update:values="(values) => (inputSubGraphFilter = values)"
      @update:meta="(meta) => (disabled = !meta.valid)"
    />
    <Button
      class="mt-3 w-full"
      :label="$t('common.submit')"
      :disabled="disabled"
      @click="clickUpdateSubGraphFilter"
    />
  </section>
</template>

<script setup lang="ts">
import { ref } from 'vue'

import { useUpdateSubGraphFilterMutation } from '@/auto_generated/graphql'
import type { SubGraphFilter } from '@/auto_generated/graphql'
import SubGraphFilterFormMolecule from '@/components/molecules/SubGraphFilterFormMolecule.vue'

const props = defineProps<{
  subGraphFilter: SubGraphFilter;
}>()

const emit = defineEmits<{
  (e: 'created', status: boolean): void;
}>()

const { executeMutation: updateSubGraphFilter } =
  useUpdateSubGraphFilterMutation()

const disabled = ref(true)
const inputSubGraphFilter = ref({})

const clickUpdateSubGraphFilter = async () => {
  await updateSubGraphFilter({
    subGraphFilterId: props.subGraphFilter.id,
    subGraphFilter: inputSubGraphFilter.value
  })
  emit('created', true)
}
</script>
