<template>
  <section>
    <strong>Project: {{ name }}</strong>
  </section>
</template>

<script setup lang="ts">
defineProps<{
  name?: string;
}>()
</script>
