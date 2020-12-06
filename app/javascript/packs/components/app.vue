<template>
  <div>
    <searchBox></searchBox>
  </div>
</template>

<script>
import searchBox from "./searchBox";
import { defineComponent } from "vue";

export default defineComponent({
  name: "App",
  components: { searchBox },
});
</script>

<style scoped></style>
