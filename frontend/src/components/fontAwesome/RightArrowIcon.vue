<template>
  <font-awesome-icon icon="arrow-right" :size="size" @click="$emit('click', $event)"
                     data-test="pagination-next-button"
  ></font-awesome-icon>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import { library } from '@fortawesome/fontawesome-svg-core';
import { faArrowRight } from '@fortawesome/free-solid-svg-icons';
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome';

library.add(faArrowRight);

export default defineComponent({
  name: 'RightArrowIcon',
  emits: ['click'],
  components: {
    FontAwesomeIcon,
  },
  props: {
    size: {
      type: String,
      default: '1x',
    },
  },
});
</script>

<style scoped></style>
