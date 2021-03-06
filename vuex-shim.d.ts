import { ComponentCustomProperties } from 'vue';
import { Store } from 'vuex';
import { result } from "./app/javascript/src/types/result";

declare module '@vue/runtime-core' {
  interface ComponentCustomProperties {
    $store: Store<result[]>
  }
}
