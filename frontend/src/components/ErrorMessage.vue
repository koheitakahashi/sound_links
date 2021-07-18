<template>
  <div class="error-message__content">
    <exclamation-circle-icon size="5x" class="error-icon"></exclamation-circle-icon>
    <div class="error-message__text">
      <p>エラーにより検索結果を表示することができませんでした。</p>
      <p>別のキーワードで検索いただくか、時間をおいてからお試しください。</p>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import ExclamationCircleIcon from './fontAwesome/ExclamationCircleIcon.vue';

export default defineComponent({
  name: 'ErrorMessage',
  components: { ExclamationCircleIcon },
});
</script>

<style scoped></style>
