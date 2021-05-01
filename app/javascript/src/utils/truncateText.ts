const MAX_STRING_LENGTH = 30;

export function truncateText(string: string): string {
  if (string.length <= MAX_STRING_LENGTH) {
    return string;
  }
  return string.slice(0, MAX_STRING_LENGTH) + "...";
}
