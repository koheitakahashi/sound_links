<template>
  <footer class="footer">
    <span class="footer__copyright">©️koheitakahashi 2021</span>
    <router-link to="/terms" class="footer__terms">免責事項</router-link>
  </footer>
</template>

<script lang="ts">
import { defineComponent } from 'vue';

export default defineComponent({
  name: 'Footer',
});
</script>

<style scoped></style>
