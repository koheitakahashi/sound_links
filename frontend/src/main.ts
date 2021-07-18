import { createApp } from 'vue';
import './registerServiceWorker';
import axios from 'axios';
import App from './App.vue';
import router from './router';
import store from './store';

import './assets/stylesheets/application.scss';
// TODO: 後で環境変数にして production も管理する
axios.defaults.baseURL = 'http://localhost:3000';

createApp(App)
  .use(store)
  .use(router)
  .mount('#app');
