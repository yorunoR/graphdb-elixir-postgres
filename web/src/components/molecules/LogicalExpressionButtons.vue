<template>
  <div class="grid">
    <div class="col panel-outline">
      <Button
        class="w-full p-button-secondary"
        label="Cancel"
        @click="() => emit('click:cancel')"
      />
    </div>
    <div class="col panel-outline">
      <Button
        class="w-full"
        label="AND"
        :disabled="disabled"
        @click="() => emit('click:and')"
      />
    </div>
    <div
      v-if="showOr"
      class="col panel-outline"
    >
      <Button
        class="w-full"
        label="OR"
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
