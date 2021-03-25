require("@rails/ujs").start();
import "../assets/stylesheets/application.scss"

import { createApp } from "vue";
import { store, key } from "./store";
import app from "./main.vue";
import TopPage from "./view/TopPage.vue";
import ResultsPage from "./view/ResultsPage.vue";

import {
  createRouter,
  createWebHistory,
  createWebHashHistory,
} from "vue-router";

const router = createRouter({
  history: createWebHistory(),
  routes: [
    { path: "/", component: TopPage, name: "TopPage" },
    { path: "/search", component: ResultsPage, name: "ResultsPage" },
  ],
});

const App = createApp(app);

App.use(router);
App.use(store, key);

document.addEventListener("DOMContentLoaded", () => {
  App.mount("#js-mount-id");
});
