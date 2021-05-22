import { createRouter, createWebHistory, RouteRecordRaw } from 'vue-router';
import TopPage from '../views/TopPage.vue';
import ResultsPage from '../views/ResultsPage.vue';
import TermsPage from '../views/TermsPage.vue';

const routes: Array<RouteRecordRaw> = [
  {
    path: '/',
    name: 'TopPage',
    component: TopPage,
  },
  {
    path: '/search',
    name: 'ResultsPage',
    component: ResultsPage,
  },
  {
    path: '/terms',
    name: 'TermsPage',
    component: TermsPage,
  },
];

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes,
});

export default router;
