<template>
  <div v-show="store.state.isLoading">aaaa</div>
  <router-view></router-view>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import { key } from "./store";
import { useStore } from "vuex";

export default defineComponent({
  name: "App",
  setup() {
    const store = useStore(key);
    return {
      store
    }
  }
});
</script>

<style scoped></style>
