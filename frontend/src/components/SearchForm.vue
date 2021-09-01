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
import SearchIcon from './fontAwesome/SearchIcon.vue';

type State = {
  keyword: string
}

const INITIAL_CURRENT_PAGE_NUMBER = 1;

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

    const state = reactive<State>({
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
      let keywordFromQuery = '';
      if (typeof route.query.keyword === 'string') {
        keywordFromQuery = route.query.keyword;
      }
      state.keyword = keywordFromQuery;
      store.dispatch('updateKeyword', keywordFromQuery);
    }

    const submitSearch = async (keyword :string) => {
      if (keyword === '') {
        return;
      }
      await store.dispatch('updateKeyword', keyword);
      await store.dispatch('updateCurrentPage', INITIAL_CURRENT_PAGE_NUMBER);

      await goToResultPage(keyword);
      // TODO: Results.vue でも検索結果をとっているので不要かもしれない
      if (props.parentComponent === 'ResultsPage') {
        await store.dispatch('fetchResults');
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
