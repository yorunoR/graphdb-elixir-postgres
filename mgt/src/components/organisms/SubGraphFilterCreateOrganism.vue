<template>
  <section>
    <h2>
      {{ $t('subGraphFilter.create') }}
    </h2>
    <SubGraphFilterFormMolecule
      is-create
      @update:values="(values) => (inputSubGraphFilter = values)"
      @update:meta="(meta) => (disabled = !meta.valid)"
    />
    <Button
      class="mt-3 w-full"
      :label="$t('common.submit')"
      :disabled="disabled"
      @click="clickCreateSubGraphFilter"
    />
  </section>
</template>

<script setup lang="ts">
import { ref } from 'vue'

import { useCreateSubGraphFilterMutation } from '@/auto_generated/graphql'
import SubGraphFilterFormMolecule from '@/components/molecules/SubGraphFilterFormMolecule.vue'

const props = defineProps<{
  divisionId: string;
}>()

const emit = defineEmits<{
  (e: 'created', status: boolean): void;
}>()

const { executeMutation: createSubGraphFilter } =
  useCreateSubGraphFilterMutation()

const disabled = ref(true)
const inputSubGraphFilter = ref({})

const clickCreateSubGraphFilter = async () => {
  await createSubGraphFilter({
    divisionId: props.divisionId,
    subGraphFilter: inputSubGraphFilter.value
  })
  emit('created', true)
}
</script>
