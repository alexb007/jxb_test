import 'package:flutter_test/flutter_test.dart';
import 'package:jxb_test/util/RpnParser.dart';

void main() {
  group('test_notation', () {
    final parser = RpnParser();
    test('check 1 * 3 / (5 - 2) parsed notation. answer should be 1 3 * 5 2 - /', () {
      expect(parser.getNotation('1*3/(5-2)').join(' '), equals('1 3 * 5 2 - /'));
    });
    test('check 0 - 1 + 2 * 3 / 4 ^ 2 parsed notation. answer 0 1 - 2 3 * 4 2 ^ / +', () {
      expect(parser.getNotation('0 - 1 + 2 * 3 / 4 ^ 2').join(' '), equals('0 1 - 2 3 * 4 2 ^ / +'));
    });
  });
}