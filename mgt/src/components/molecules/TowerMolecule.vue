<template>
  <section>
    <div class="white-space-nowrap overflow-hidden text-overflow-ellipsis">
      <strong>└ {{ name }}</strong>
    </div>
  </section>
</template>

<script setup lang="ts">
defineProps<{
  name?: string;
}>()
</script>
