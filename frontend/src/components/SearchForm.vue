<template>
  <div class="search-form">
    <label for="form"></label>
    <input
      v-model="state.keyword"
      @keypress.enter="submitSearch(state.keyword)"
      type="search"
      name="keyword"
      id="form"
      data-test="search-form"
      placeholder="楽曲名を入力してください"
      class="search-form__input"
    />
    <button
      @click="submitSearch(state.keyword)"
      data-test="search-submit-button"
      class="search-form__button"
    >
      <search-icon size="lg" class="search-form-button__icon"></search-icon>
    </button>
  </div>
</template>

<script lang="ts">
import { defineComponent, reactive } from 'vue';
import { useRouter, useRoute } from 'vue-router';
import { useStore } from 'vuex';
import axios from 'axios';
import SearchIcon from './fontAwesome/SearchIcon.vue';

export default defineComponent({
  name: 'SearchForm',
  components: {
    SearchIcon,
  },
  props: {
    parentComponent: {
      type: String,
      default: 'TopPage',
    },
  },
  setup(props) {
    const router = useRouter();
    const route = useRoute();
    const store = useStore();

    const state = reactive({
      keyword: '',
    });

    function goToResultPage(keyword :string) {
      router.push({
        name: 'ResultsPage',
        query: { keyword },
      });
    }

    // NOTE: 直接URLにアクセスされた場合の対応
    function setKeyword() {
      if (route.query.keyword) {
        // NOTE: route.query.keywords をそのまま state.keywords にいれると、route.query.keywordsが
        // String 以外にもなり得るため代入できない
        // TODO: type エラーが解消できないため、一旦コメントアウトする
        // let params = new URLSearchParams(window.location.search);
        // state.keyword = params.get("keyword");
      }
    }

    const fetchResults = async (keyword :string) => {
      try {
        store.commit('setIsLoading', true);
        store.commit('setKeyword', keyword);
        const response = await axios.get('api/v1/search', {
          params: {
            keyword: store.state.keyword,
            page: store.state.currentPage,
          },
        });
        await store.dispatch('updateResultsAndPage', response.data);
        store.commit('setIsLoading', false);
      } catch (error) {
        store.commit('setIsLoading', false);
        store.commit('setShowError', true);
      }
    };

    const submitSearch = async (keyword :string) => {
      if (keyword === '') {
        return;
      }
      store.commit('setCurrentPage', 1);

      goToResultPage(keyword);
      if (props.parentComponent === 'ResultsPage') {
        await fetchResults(keyword);
      }
    };

    setKeyword();
    return {
      state,
      submitSearch,
    };
  },
});
</script>

<style scoped></style>
