require("@rails/ujs").start();

import { createApp } from "vue";
import { store, key } from "./store";
import app from "./main.vue";
import topPage from "./view/topPage.vue";
import resultsPage from "./view/resultsPage.vue";

import {
  createRouter,
  createWebHistory,
  createWebHashHistory,
} from "vue-router";

const router = createRouter({
  history: createWebHistory(),
  routes: [
    { path: "/", component: topPage, name: "topPage" },
    { path: "/search", component: resultsPage, name: "resultsPage" },
  ],
});

const App = createApp(app);

App.use(router);
App.use(store, key);

document.addEventListener("DOMContentLoaded", () => {
  App.mount("#js-mount-id");
});
