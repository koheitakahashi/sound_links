<template>
  <div class="error-message-layout">
    <div class="error-message__content">
      <div class="error-message__header">
        <img src="/img/icons/exclamation-icon.svg" alt="エクスクラメーションマークのアイコン">
        <h2>何らかの問題が起きました</h2>
      </div>
      <div class="error-message__text">
        <p>ご迷惑おかけして、申し訳有りません。</p>
        <p>問題が起きてページが表示できませんでした。</p>
        <p>別のキーワードで検索いただくか、時間をおいてからお試しください。</p>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';

export default defineComponent({
  name: 'ErrorMessage',
});
</script>

<style scoped></style>
