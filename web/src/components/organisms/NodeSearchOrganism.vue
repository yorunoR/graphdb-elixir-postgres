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
        :label="$t('nodeType.title')"
        class="p-button-outlined"
        @click="selected = 'nodeType'"
      />
      <Button
        :label="$t('common.name')"
        class="p-button-outlined mt-2"
        @click="selected = 'name'"
      />
      <Button
        :label="$t('common.uid')"
        class="p-button-outlined mt-2"
        @click="selected = 'uid'"
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
      v-show="selected == 'uid'"
      class="mt-2"
    >
      <LogicalInput
        v-model:not="uidNot"
        v-model:text="uid"
        :placeholder="$t('common.uid')"
        :errors="uidErrors.join(' ')"
        :showOr="parameters.length > 0"
        :disabled="!uidMeta.valid"
        @click:cancel="selected = null"
        @click:and="() => addParameter('uid', '*')"
        @click:or="() => addParameter('uid', '+')"
      />
    </div>
    <div
      v-show="selected == 'nodeType'"
      class="text-left"
    >
      <div class="py-3">
        <strong>{{ $t('nodeType.title') }}</strong>
      </div>
      <div
        v-if="data && data.division"
        class="flex flex-row grid"
      >
        <div
          v-for="option in data.division.nodeTypes ?? []"
          :key="option.uid"
          class="mx-2"
        >
          <RadioButton
            v-model="nodeTypeUid"
            :input-id="`nodeType-${option.uid}`"
            name="nodeTypeUid"
            :value="option.uid"
          />
          <label
            :for="`nodeType-${option.uid}`"
            class="ml-2 cursor-pointer"
          >{{
            option.name
          }}</label>
        </div>
      </div>
      <div class="mt-3">
        <LogicalExpressionButtons
          :disabled="!nodeTypeUidMeta.valid"
          :show-or="parameters.length > 0"
          @click:cancel="selected = null"
          @click:and="() => addParameter('nodeTypeUid', '*')"
          @click:or="() => addParameter('nodeTypeUid', '+')"
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

import { callDivisionNodeTypesQuery } from '@/call/queries'
import LogicalExpressionButtons from '@/components/molecules/LogicalExpressionButtons.vue'
import LogicalInput from '@/components/molecules/LogicalInput.vue'

const props = defineProps<{
  divisionId: string;
  toggleable?: boolean;
  buttonLabel: string;
  initial: string;
}>()

const emit = defineEmits<{
  (e: 'search', parameters: string): void;
}>()

const selected = ref(null)
const parameters = ref(JSON.parse(props.initial))

const { data } = callDivisionNodeTypesQuery(props.divisionId)

const { resetForm, values: inputValues } = useForm({
  initialValues: {
    nameNot: false,
    uidNot: false
  }
})

const isRequired = (value) => (value ? true : 'This field is required')
const { value: name, errors: nameErrors, meta: nameMeta } = useField('name', isRequired)
const { value: nameNot } = useField('nameNot')
const { value: uid, errors: uidErrors, meta: uidMeta } = useField('uid', isRequired)
const { value: uidNot } = useField('uidNot')
const { value: nodeTypeUid, errors: _nodeTypeUidErrors, meta: nodeTypeUidMeta } = useField(
  'nodeTypeUid',
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
