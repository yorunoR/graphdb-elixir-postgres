<template>
  <section class="flex flex-column justify-content-start align-items-start">
    <input
      ref="fileRef"
      type="file"
      hidden
      multiple
      @change="(event) => filesSelected(event)"
    >
    <div class="mt-2 flex gap-2">
      <Button
        icon="pi pi-images"
        class="p-button-rounded"
        @click="() => chooseCallback()"
      />
      <Button
        icon="pi pi-cloud-upload"
        class="p-button-rounded p-button-success"
        :disabled="!meta.valid"
        @click="() => uploadCallback()"
      />
      <Button
        icon="pi pi-times"
        class="p-button-rounded p-button-danger"
        :disabled="!meta.valid"
        @click="() => clearCallback()"
      />
    </div>
    <ul v-if="files">
      <li
        v-for="file of files"
        :key="file"
      >
        {{ file.name }} - {{ file.size }}bytes
      </li>
    </ul>
    <div
      v-if="filesErrors.length > 0"
      class="mt-3"
    >
      <div class="p-error">
        {{ filesErrors.join(" ") }}
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
import { useToast } from 'primevue/usetoast'
import { useField, useForm } from 'vee-validate'
import { ref } from 'vue'

import type { EdgeType } from '@/auto_generated/graphql'
import { uploadEdges } from '@/call/api'

const props = defineProps<{
  edgeType: EdgeType;
}>()

const toast = useToast()
const fileRef = ref(null)

const { meta, resetForm, setFieldValue } = useForm({
  initialValues: {
    files: []
  }
})

const isRequired = (value) =>
  value.length > 0 ? true : 'This field is required'
const { value: files, errors: filesErrors } = useField('files', isRequired)

const chooseCallback = () => {
  fileRef.value.click()
}

const filesSelected = (event) => {
  let newFiles = files.value
  for (const file of event.target.files) {
    newFiles = newFiles.concat(file)
  }
  setFieldValue('files', newFiles)
}

const uploadCallback = async () => {
  const formData = new FormData()
  files.value.forEach((file) => {
    const blob = new Blob([file], { type: 'text/csv' })
    formData.append('files[]', blob, file.name)
  })

  const result = await uploadEdges({
    edgeTypeId: props.edgeType.id,
    data: formData
  })
  if (result.error) {
    toast.add({
      severity: 'error',
      summary: 'Upload edges',
      detail: result.error.message
    })
  } else {
    toast.add({
      severity: 'info',
      summary: 'Upload edges',
      detail: 'Success'
    })
    resetForm()
    fileRef.value.value = null
  }
}

const clearCallback = () => {
  fileRef.value.value = ''
  setFieldValue('files', [])
}
</script>
