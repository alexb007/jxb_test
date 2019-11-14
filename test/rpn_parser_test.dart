import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jxb_test/util/RpnParser.dart';

void main() {
  group('test_notation', ()  {
    final parser = RpnParser();
    var notation = null;
    test('1 * 3 / (5 - 2) => 1 3 * 5 2 - /', () async {
      notation = await parser.getNotation('1*3/(5-2)');
      expect(notation.join(' '), equals('1 3 * 5 2 - /'));
    });
    test('0 - 1 + 2 * 3 / 4 ^ 2 => 0 1 - 2 3 * 4 2 ^ / +', () async {
      notation = await parser.getNotation('0 - 1 + 2 * 3 / 4 ^ 2');
      expect(notation.join(' '), equals('0 1 - 2 3 * 4 2 ^ / +'));
    });
    test('1 + (2 + (3 + 4(6 - 5))) => 1 2 3 4 6 5 - * + + +', () async {
      notation = await parser.getNotation('1 + (2 + (3 + 4(6 - 5)))');
      expect(notation.join(' '), equals('1 2 3 4 6 5 - * + + +'));
    });
    test('-5 + 3 + -3 => 0 5 3 + 0 3 - +', () async {
      notation = await parser.getNotation('-5 + 3 + -3');
      expect(notation.join(' '), equals('0 5 - 3 + 0 3 - +'));
    });
    test('(2 + 2) - 3 * 5x => 1 2 3 4 6 5 - * + + +', () async {
      notation = await parser.getNotation('(2 + 2) - 3 * 5x');
      expect(notation.join(' '), equals('2 2 + 3 5 x * * -'));
    });
    test('2 * (-3 + 3) => 2 0 3 - 3 + *', () async {
      notation = await parser.getNotation('2 * (-3 + 3)');
      expect(notation.join(' '), equals('2 0 3 - 3 + *'));
    });


  });
}