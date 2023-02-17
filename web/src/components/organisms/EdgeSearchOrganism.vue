<template>
  <Panel
    :header="$t('common.search')"
    :toggleable="toggleable"
    :collapsed="toggleable"
  >
    <div
      v-if="!selected"
      class="flex flex-column"
    >
      <Button
        :label="$t('edgeType.title')"
        class="p-button-outlined"
        @click="selected = 'edgeType'"
      />
      <Button
        :label="$t('common.name')"
        class="p-button-outlined mt-2"
        @click="selected = 'name'"
      />
      <Button
        v-show="nodeSearch"
        label="Start node name"
        class="p-button-outlined mt-2"
        @click="selected = 'startNodeName'"
      />
      <Button
        v-show="nodeSearch"
        label="End node name"
        class="p-button-outlined mt-2"
        @click="selected = 'endNodeName'"
      />
      <Button
        v-show="nodeSearch"
        label="Start node UID"
        class="p-button-outlined mt-2"
        @click="selected = 'startNodeUid'"
      />
      <Button
        v-show="nodeSearch"
        label="End node UID"
        class="p-button-outlined mt-2"
        @click="selected = 'endNodeUid'"
      />
    </div>
    <div
      v-show="selected == 'name'"
      class="mt-2"
    >
      <LogicalInput
        v-model:not="nameNot"
        v-model:text="name"
        :placeholder="$t('common.name')"
        :errors="nameErrors.join(' ')"
        :showOr="parameters.length > 0"
        :disabled="!nameMeta.valid"
        @click:cancel="selected = null"
        @click:and="() => addParameter('name', '*')"
        @click:or="() => addParameter('name', '+')"
      />
    </div>
    <div
      v-show="selected == 'startNodeName'"
      class="mt-2"
    >
      <LogicalInput
        v-model:not="startNodeNameNot"
        v-model:text="startNodeName"
        placeholder="Start node name"
        :errors="startNodeNameErrors.join(' ')"
        :showOr="parameters.length > 0"
        :disabled="!startNodeNameMeta.valid"
        @click:cancel="selected = null"
        @click:and="() => addParameter('startNodeName', '*')"
        @click:or="() => addParameter('startNodeName', '+')"
      />
    </div>
    <div
      v-show="selected == 'startNodeUid'"
      class="mt-2"
    >
      <LogicalInput
        v-model:not="startNodeUidNot"
        v-model:text="startNodeUid"
        placeholder="Start node UID"
        :errors="startNodeUidErrors.join(' ')"
        :showOr="parameters.length > 0"
        :disabled="!startNodeUidMeta.valid"
        @click:cancel="selected = null"
        @click:and="() => addParameter('startNodeUid', '*')"
        @click:or="() => addParameter('startNodeUid', '+')"
      />
    </div>
    <div
      v-show="selected == 'endNodeName'"
      class="mt-2"
    >
      <LogicalInput
        v-model:not="endNodeNameNot"
        v-model:text="endNodeName"
        placeholder="End node name"
        :errors="endNodeNameErrors.join(' ')"
        :showOr="parameters.length > 0"
        :disabled="!endNodeNameMeta.valid"
        @click:cancel="selected = null"
        @click:and="() => addParameter('endNodeName', '*')"
        @click:or="() => addParameter('endNodeName', '+')"
      />
    </div>
    <div
      v-show="selected == 'endNodeUid'"
      class="mt-2"
    >
      <LogicalInput
        v-model:not="endNodeUidNot"
        v-model:text="endNodeUid"
        placeholder="End node UID"
        :errors="endNodeUidErrors.join(' ')"
        :showOr="parameters.length > 0"
        :disabled="!endNodeUidMeta.valid"
        @click:cancel="selected = null"
        @click:and="() => addParameter('endNodeUid', '*')"
        @click:or="() => addParameter('endNodeUid', '+')"
      />
    </div>
    <div
      v-show="selected == 'edgeType'"
      class="text-left"
    >
      <div class="py-3">
        <strong>
          {{ $t('edgeType.title') }}
        </strong>
      </div>
      <div
        v-if="data && data.division"
        class="flex flex-row grid"
      >
        <div
          v-for="option in data.division.edgeTypes ?? []"
          :key="option.uid"
          class="mx-2"
        >
          <RadioButton
            v-model="edgeTypeUid"
            :input-id="`edgeType-${option.uid}`"
            name="edgeTypeUid"
            :value="option.uid"
          />
          <label
            :for="`edgeType-${option.uid}`"
            class="ml-2 cursor-pointer"
          >{{
            option.name
          }}</label>
        </div>
      </div>
      <div class="mt-3">
        <LogicalExpressionButtons
          :disabled="!edgeTypeUidMeta.valid"
          :show-or="parameters.length > 0"
          @click:cancel="selected = null"
          @click:and="() => addParameter('edgeTypeUid', '*')"
          @click:or="() => addParameter('edgeTypeUid', '+')"
        />
      </div>
    </div>
    <section class="mt-3">
      <div class="text-left">
        <strong>Parameters</strong>
        <VueJsonPretty
          v-model:data="parameters"
          show-icon
          show-length
          collapsed-on-click-brackets
          :show-line="false"
          :show-double-quotes="false"
          editable
          editableTrigger="dblclick"
        />
      </div>
    </section>
    <div
      class="mt-3 grid"
    >
      <div class="col panel-outline">
        <Button
          class="w-full p-button-secondary"
          :label="$t('common.reset')"
          :disabled="lastParameter == null"
          @click="() => reset()"
        />
      </div>
      <div class="col panel-outline">
        <Button
          :disabled="selected"
          class="w-full"
          :label="buttonLabel"
          @click="() => search()"
        />
      </div>
    </div>
  </Panel>
</template>

<script setup lang="ts">
import { useField, useForm } from 'vee-validate'
import { ref, computed } from 'vue'
import VueJsonPretty from 'vue-json-pretty'
import 'vue-json-pretty/lib/styles.css'

import { callDivisionEdgeTypesQuery } from '@/call/queries'
import LogicalExpressionButtons from '@/components/molecules/LogicalExpressionButtons.vue'
import LogicalInput from '@/components/molecules/LogicalInput.vue'

const props = defineProps<{
  divisionId: string;
  toggleable?: boolean;
  nodeSearch?: boolean;
  buttonLabel: string;
  initial: string;
}>()

const emit = defineEmits<{
  (e: 'search', parameters: string): void;
}>()

const selected = ref(null)
const parameters = ref(JSON.parse(props.initial))

const { data } = callDivisionEdgeTypesQuery(props.divisionId)

const { resetForm, values: inputValues } = useForm({
  initialValues: {
    nameNot: false,
    startNodeUidNot: false,
    startNodeNameNot: false,
    endNodeUidNot: false,
    endNodeNameNot: false
  }
})

const isRequired = (value) => (value ? true : 'This field is required')
const { value: name, errors: nameErrors, meta: nameMeta } = useField('name', isRequired)
const { value: nameNot } = useField('nameNot')
const { value: startNodeName, errors: startNodeNameErrors, meta: startNodeNameMeta } = useField('startNodeName', isRequired)
const { value: startNodeNameNot } = useField('startNodeNameNot')
const { value: startNodeUid, errors: startNodeUidErrors, meta: startNodeUidMeta } = useField('startNodeUid', isRequired)
const { value: startNodeUidNot } = useField('startNodeUidNot')
const { value: endNodeName, errors: endNodeNameErrors, meta: endNodeNameMeta } = useField('endNodeName', isRequired)
const { value: endNodeNameNot } = useField('endNodeNameNot')
const { value: endNodeUid, errors: endNodeUidErrors, meta: endNodeUidMeta } = useField('endNodeUid', isRequired)
const { value: endNodeUidNot } = useField('endNodeUidNot')
const { value: edgeTypeUid, errors: _edgeTypeUidErrors, meta: edgeTypeUidMeta } = useField(
  'edgeTypeUid',
  isRequired
)

const lastParameter = computed(() => {
  return parameters.value.findLast((parameter) => parameter.key !== 'operator')
})

const addParameter = (key, operator) => {
  const term = {
    type: inputValues[key + 'Not'] ? 'not_term' : 'term',
    value: inputValues[key]
  }

  if (lastParameter.value == null) {
    parameters.value.push({ key, values: [term] })
  } else if (lastParameter.value.key !== key) {
    parameters.value.push({ key: 'operator', value: operator })
    parameters.value.push({ key, values: [term] })
  } else {
    lastParameter.value.values.push({ type: 'operator', value: operator })
    lastParameter.value.values.push(term)
  }

  resetForm()
  selected.value = null
}

const reset = () => {
  parameters.value.splice(0)
  resetForm()
  selected.value = null
}

const search = () => {
  emit('search', JSON.stringify(parameters.value))
}
</script>
