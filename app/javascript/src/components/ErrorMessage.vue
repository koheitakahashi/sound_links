<template>
  <div class="error-message__content">
    <exclamation-icon size="6x" class="error-icon"></exclamation-icon>
    <div class="error-message__text">
      <p>エラーにより検索結果を表示することができませんでした。</p>
      <p>別のキーワードで検索いただくか、時間をおいてからお試しください。</p>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import ExclamationIcon from "./ExclamationIcon";

export default defineComponent({
  name: "ErrorMessage",
  components: {
    ExclamationIcon,
  },
});
</script>

<style scoped></style>
