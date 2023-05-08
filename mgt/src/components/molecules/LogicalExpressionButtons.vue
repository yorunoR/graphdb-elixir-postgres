<template>
  <div class="grid">
    <div class="col panel-outline">
      <Button
        class="w-full p-button-secondary text-xs"
        label="Cancel"
        @click="() => emit('click:cancel')"
      />
    </div>
    <div class="col panel-outline">
      <Button
        class="w-full text-xs"
        label="ＡＮＤ"
        :disabled="disabled"
        @click="() => emit('click:and')"
      />
    </div>
    <div
      v-if="showOr"
      class="col panel-outline"
    >
      <Button
        class="w-full text-xs"
        label="ＯＲ"
        :disabled="disabled"
        @click="() => emit('click:or')"
      />
    </div>
  </div>
</template>

<script setup lang="ts">
defineProps<{
  showOr?: boolean;
  disabled: boolean;
}>()

const emit = defineEmits<{
  (e: 'click:cancel'): void;
  (e: 'click:and'): void;
  (e: 'click:or'): void;
}>()
</script>
