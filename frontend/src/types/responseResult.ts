import { sound } from '@/types/sound';

export type responseResult = {
  data: {
    results: sound[];
    currentPage: number;
  }
};
