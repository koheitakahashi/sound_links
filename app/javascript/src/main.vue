<template>
  <router-view></router-view>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import { key } from "./store";
import { useStore } from "vuex";

export default defineComponent({
  name: "App",
});
</script>

<style scoped></style>
