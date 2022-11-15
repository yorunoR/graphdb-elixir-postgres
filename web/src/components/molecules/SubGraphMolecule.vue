<template>
  <section>
    <strong>&emsp;&emsp;└ SubGraph: {{ name }}</strong>
  </section>
</template>

<script setup lang="ts">
defineProps<{
  name?: string;
}>()
</script>
