<template>
  <footer class="footer">
    <router-link to="/terms" class="footer__terms">免責事項</router-link>
    <span class="footer__copyright">©️koheitakahashi 2021</span>
    <a href="https://github.com/koheitakahashi/sound_links">
      <img src="../../public/img/icons/github-icon.svg"
           alt="GitHubのアイコン"
           class="footer__github-icon">
    </a>
  </footer>
</template>

<script lang="ts">
import { defineComponent } from 'vue';

export default defineComponent({
  name: 'Footer',
});
</script>

<style scoped></style>
