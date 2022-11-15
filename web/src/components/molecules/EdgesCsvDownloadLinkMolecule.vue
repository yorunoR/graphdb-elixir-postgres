<template>
  <div
    class="underline cursor-pointer text-right"
    @click="(event) => downloadCsv(filename, records)"
  >
    Download template
  </div>
</template>

<script setup lang="ts">
defineProps<{
  filename: string;
  records: object[];
}>()

const downloadCsv = (filename, records) => {
  const data =
    'skip,start_node_uid,end_node_uid,name,' +
    records.map((record) => record.uid).join(',') +
    '\n' +
    '空欄で無い時スキップ,,,,' +
    records.map((record) => record.name).join(',')
  const bom = new Uint8Array([0xef, 0xbb, 0xbf])
  const blob = new Blob([bom, data], { type: 'text/csv' })
  const url = URL.createObjectURL(blob)
  const link = document.createElement('a')
  const now = new Date()

  link.download =
    filename + '-' + now.toLocaleString().replace(/\s+/g, '_') + '.csv'
  link.href = url
  link.click()
  URL.revokeObjectURL(url)
}
</script>
