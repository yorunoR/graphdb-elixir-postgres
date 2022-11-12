<template>
  <section>
    <strong>└ Tower: {{ name }}</strong>
  </section>
</template>

<script setup lang="ts">
defineProps<{
  name?: string;
}>()
</script>
