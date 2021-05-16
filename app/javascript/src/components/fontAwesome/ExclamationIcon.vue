<template>
  <font-awesome-icon icon="exclamation-circle" :size="size"></font-awesome-icon>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import { library } from "@fortawesome/fontawesome-svg-core";
import { faExclamationCircle } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";

library.add(faExclamationCircle);

export default defineComponent({
  name: "ExclamationIcon",
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
