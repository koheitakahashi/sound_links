<template>
  <font-awesome-icon icon="search" :size="size"></font-awesome-icon>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import { library } from "@fortawesome/fontawesome-svg-core";
import { faSearch } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";

library.add(faSearch);

export default defineComponent({
  name: "SearchIcon",
  components: {
    FontAwesomeIcon,
  },
  props: {
    size: {
      type: String,
      default: "1x",
    },
  },
});
</script>

<style scoped></style>
