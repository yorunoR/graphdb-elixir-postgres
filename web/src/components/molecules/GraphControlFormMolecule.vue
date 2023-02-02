<template>
  <div>
    <DataTable
      :value="mapToList(omitCommands(graphStatus))"
      responsive-layout="scroll"
    >
      <Column
        field="key"
        header="key"
      />
      <Column
        field="val"
        header="val"
      />
    </DataTable>
    <Button
      label="Start"
      class="w-full mt-4"
      :disabled="graphStatus.status"
      @click="() => emit('start')"
    />
    <Button
      label="Stop"
      class="w-full mt-2"
      :disabled="!graphStatus.status"
      @click="() => emit('stop')"
    />
    <Dropdown
      v-model="command"
      class="w-full mt-4"
      :disabled="!graphStatus.status"
      :options="graphStatus.commands"
      optionLabel="name"
      optionValue="name"
      placeholder="Command"
    />
    <div
      v-if="selectedCommand"
      class="mt-2 p-2 text-left text-sm surface-200 border-round-xs"
      style="white-space: pre-wrap"
    >
      <span>{{ selectedCommand.description }}</span>
    </div>
    <InputText
      v-model="first"
      class="w-full mt-2"
      type="text"
      placeholder="First argument"
      :disabled="!graphStatus.status || !command || selectedCommand.arity === 0"
    />
    <InputText
      v-model="second"
      class="w-full mt-2"
      type="text"
      placeholder="Second argument"
      :disabled="!graphStatus.status || !command || selectedCommand.arity < 2"
    />
    <Button
      label="Submit"
      class="w-full mt-2"
      :disabled="!graphStatus.status || !meta.valid"
      @click="() => clickCommand()"
    />
  </div>
  <Dialog
    v-model:visible="visible"
    modal
  >
    <template #header>
      <h3>Result</h3>
    </template>
    <DataTable
      :value="result.props"
      responsive-layout="scroll"
    >
      <Column
        field="key"
        header="key"
      />
      <Column
        field="val"
        header="val"
      />
    </DataTable>
    <template #footer>
      <Button
        label="Close"
        icon="pi pi-times"
        class="p-button-text"
        @click="visible = false"
      />
      <Button
        label="Save"
        icon="pi pi-check"
        autofocus
        @click="visible = false"
      />
    </template>
  </Dialog>
</template>

<script setup lang="ts">
import cloneDeep from 'lodash/cloneDeep'
import isEqual from 'lodash/isEqual'
import { useField, useForm } from 'vee-validate'
import { computed, ref, toRefs, watch } from 'vue'

import type { GraphStatus, Result } from '@/auto_generated/graphql'
import { mapToList } from '@/services/utils'

const props = defineProps<{
  subGraphFilterId: string;
  graphStatus: GraphStatus;
  result?: Result;
  fetching: boolean;
}>()

const emit = defineEmits<{
  (e: 'start'): void;
  (e: 'stop'): void;
  (e: 'command', value: { subGraphFilterId: string, command: string, opts: [string] }): void;
}>()

const unchanged = ref(true)
const visible = ref(false)

const { fetching } = toRefs(props)

const { meta, values } = useForm({})

const isRequired = (value) => (value ? true : 'This field is required')
const { value: command } = useField('command', isRequired)
const { value: first } = useField('first')
const { value: second } = useField('second')

let previous = {}
const clickCommand = () => {
  if (unchanged.value) {
    visible.value = true
  } else {
    emit('command', {
      subGraphFilterId: props.subGraphFilterId,
      command: command.value,
      opts: [first.value, second.value]
    })
    previous = cloneDeep(values)
    unchanged.value = true
  }
}

watch([meta], () => {
  unchanged.value = isEqual(previous, values)
})

watch([fetching], () => {
  visible.value = !fetching.value
})

const omitCommands = (map) => {
  const clone = cloneDeep(map)
  delete clone.commands
  return clone
}

const selectedCommand = computed(() => {
  if (!command.value) { return }

  return props.graphStatus.commands.find(algorithm => algorithm.name === command.value)
})
</script>
