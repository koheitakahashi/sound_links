import truncateText from '@/utils/truncateText';

describe('truncateText', () => {
  it('Window.innerWidth が 480 で、引数に渡した文字列が30文字の場合、引数に渡した文字列がそのまま返る',
    () => {
      Object.defineProperty(window, 'innerWidth', {
        writable: true,
        configurable: true,
        value: 480,
      });
      window.dispatchEvent(new Event('resize'));

      const string = 'a'.repeat(30);

      expect(truncateText(string)).toBe(string);
    });

  it('Window.innerWidth が 480 で、引数に渡した文字列が31文字の場合、引数に渡した文字列が30文字に切り捨てられ、末尾に...が入った文字列が返る',
    () => {
      Object.defineProperty(window, 'innerWidth', {
        writable: true,
        configurable: true,
        value: 480,
      });
      window.dispatchEvent(new Event('resize'));

      const string = 'a'.repeat(31);
      const expected = `${'a'.repeat(30)}...`;

      expect(truncateText(string)).toBe(expected);
    });

  it('Window.innerWidth が 481 で、引数に渡した文字列が100文字の場合、引数に渡した文字列がそのまま返る',
    () => {
      Object.defineProperty(window, 'innerWidth', {
        writable: true,
        configurable: true,
        value: 481,
      });
      window.dispatchEvent(new Event('resize'));

      const string = 'a'.repeat(100);

      expect(truncateText(string)).toBe(string);
    });

  it('Window.innerWidth が 481 で、引数に渡す文字列が100文字の場合、引数に渡した文字列が100文字で切り捨てられ、末尾に...が追加されてた文字列が返る',
    () => {
      Object.defineProperty(window, 'innerWidth', {
        writable: true,
        configurable: true,
        value: 481,
      });
      window.dispatchEvent(new Event('resize'));

      const string = 'a'.repeat(101);
      const expected = `${'a'.repeat(100)}...`;

      expect(truncateText(string)).toBe(expected);
    });
});
