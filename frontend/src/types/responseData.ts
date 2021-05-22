export type sound = {
  isrc: string;
  thumbnailUrl: string;
  title: string;
  artist: string;
  spotifyUrl: string;
  appleMusicUrl: string;
  kkboxUrl: string;
};

export type responseData = {
  results: sound[];
  currentPage: number;
};
