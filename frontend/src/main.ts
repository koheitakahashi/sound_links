import { createApp } from 'vue';
import './registerServiceWorker';
import axios from 'axios';
import App from './App.vue';
import router from './router';
import store from './store';

import './assets/stylesheets/application.scss';
// TODO: 後で環境変数にする
axios.defaults.baseURL = process.env.NODE_ENV === 'production' ? 'http://api.sound-links.com' : 'http://localhost:3000';
axios.defaults.headers.get['Access-Control-Allow-Origin'] = process.env.NODE_ENV === 'production' ? 'http://sound-links.com' : 'http://localhost:8080';

createApp(App)
  .use(store)
  .use(router)
  .mount('#app');
