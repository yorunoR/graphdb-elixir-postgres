<template>
  <section>
    <strong>&emsp;└ Division: {{ name }}</strong>
  </section>
</template>

<script setup lang="ts">
defineProps<{
  name?: string;
}>()
</script>
