export type sound = {
  isrc: string;
  thumbnailUrl: string;
  title: string;
  artist: string;
  spotifyUrl: string;
  appleMusicUrl: string;
  kkboxUrl: string;
};

export type responseResult = {
  data: {
    results: sound[];
    currentPage: number;
  }
};
