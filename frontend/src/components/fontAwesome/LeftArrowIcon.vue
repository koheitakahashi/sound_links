<template>
  <font-awesome-icon icon="chevron-left" :size="size" @click="$emit('click', $event)"
                     data-test="pagination-previous-button"
  ></font-awesome-icon>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import { library } from '@fortawesome/fontawesome-svg-core';
import { faChevronLeft } from '@fortawesome/free-solid-svg-icons';
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome';

library.add(faChevronLeft);

export default defineComponent({
  name: 'LeftArrowIcon',
  components: {
    FontAwesomeIcon,
  },
  emits: ['click'],
  props: {
    size: {
      type: String,
      default: '1x',
    },
  },
});
</script>

<style scoped></style>
