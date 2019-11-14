import 'dart:collection';

const operations = {
  '(': 0,
  ')': 0,
  '*': 2,
  '/': 2,
  '+': 1,
  '-': 1,
  '^': 3,
};

extension on String {
  bool get isDigit => (this.codeUnitAt(0) ^ 0x30) <= 9;

  bool get isLetter => (this.codeUnitAt(0) ^ 0x61) <= 27;

  bool get isOperator => operations.containsKey(this);
}

class RpnParser {
  var _notation = Queue();
  var _opQueue = Queue();
  var currentElement = '';
  var lastChar = '';

  RpnParser();

  void parseOperator(String operator) {
    if (currentElement.isNotEmpty) {
      _notation.add(double.tryParse(currentElement) ?? currentElement);
    }
    if (lastChar.isOperator) {
      if (lastChar != ')' && (operator == '+' || operator == '-'))
        _notation.add(0);
      if (operations[operator] * operations[lastChar] > 3)
        throw ArgumentError('Expression is not valid');
    }
    if (operator == '(') {
      if (currentElement.isNotEmpty) {
        currentElement = '';
        lastChar = operator;
        parseOperator('*');
      }
      _opQueue.add(operator);
      return;
    }
    if (_notation.isEmpty) {
      if (operator != '+' && operator != '-' && operator != '(')
        throw ArgumentError('Expression is not valid');
      if (operator == '+' || operator == '-') _notation.add(0);
    }

    if (operator == ')') {
      while (_opQueue.isNotEmpty && _opQueue.last != '(') {
        _notation.add(_opQueue.removeLast());
      }
      var pairFound = _opQueue.isNotEmpty && _opQueue.last == '(';
      if (pairFound) {
        _opQueue.removeLast();
      } else {
        throw ArgumentError('Expression is not valid. Missing brackets pair.');
      }
      currentElement = '';
      lastChar = operator;
      return;
    }
    while (currentElement.isNotEmpty &&
        _opQueue.isNotEmpty &&
        operations[_opQueue.last] >= operations[operator]) {
      _notation.add(_opQueue.removeLast());
    }
    currentElement = '';
    lastChar = operator;
    _opQueue.add(operator);
  }

  void parseDigit(String number) {
    currentElement += number;
    lastChar = number;
  }

  void parseLetter(String letter) {
    if (double.tryParse(currentElement) != null) {
      _notation.add(double.parse(currentElement));
      currentElement = letter;
      parseOperator('*');
      return;
    }
    currentElement += letter;
    lastChar = letter;
  }

  Queue getNotation(String expression) {
    _notation.clear();
    _opQueue.clear();
    currentElement = '';
    for (int index = 0; index < expression.length; index++) {
      var c = expression[index];
      if (c == ' ') continue;
      // c is operation char
      if (c.isOperator) {
        parseOperator(c);
      } else {
        if (index > 0 && expression[index - 1] == ')') parseOperator('*');
        if (c.isDigit)
          parseDigit(c);
        else if (c.isLetter)
          parseLetter(c);
        else
          throw ArgumentError('Expression contains unexpected characters');
      }
    }
    if (currentElement.isNotEmpty) {
      _notation.add(double.tryParse(currentElement) ?? currentElement);
    }
    while (_opQueue.isNotEmpty) {
      var op = _opQueue.removeLast();
      if (op.toString() == '(') {
        throw ArgumentError('Expression is not valid. Missing breckets pair.');
      }
      _notation.add(op);
    }
    return _notation;
  }
}
