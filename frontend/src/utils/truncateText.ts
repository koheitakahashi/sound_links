const MAX_STRING_LENGTH_WITH_WIDE_WIDTH = 100;
const MAX_STRING_LENGTH_WITH_NARROW_WIDTH = 30;
const NARROW_WIDTH = 480;

// TODO: リファクタリングする
export default function truncateText(string: string): string {
  if (window.innerWidth <= NARROW_WIDTH) {
    if (string.length <= MAX_STRING_LENGTH_WITH_NARROW_WIDTH) {
      return string;
    }
    return `${string.slice(0, MAX_STRING_LENGTH_WITH_NARROW_WIDTH)}...`;
  }
  if (string.length <= MAX_STRING_LENGTH_WITH_WIDE_WIDTH) {
    return string;
  }
  return `${string.slice(0, MAX_STRING_LENGTH_WITH_WIDE_WIDTH)}...`;
}
