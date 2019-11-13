import 'dart:collection';

class RpnParser {
  static const operations = {
    '(': 0,
    ')': 0,
    '*': 2,
    '/': 2,
    '+': 1,
    '-': 1,
    '^': 3,
  };

  RpnParser();

  Queue getNotation(String expression) {
    var _notation = Queue();
    var _opQueue = Queue();
    var currentElement = '';
    for (var c in expression.split('')) {
      if (c == ' ') continue;

      // c is operation char
      if (operations.containsKey(c)) {
        if (currentElement.isNotEmpty) {
          _notation.add(currentElement);
          currentElement = '';
        }
        if (c == '(') {
          _opQueue.add(c);
          continue;
        }
        if (_opQueue.isEmpty) {
          _opQueue.add(c);
        } else {
          if (c == ')') {
            while (_opQueue.isNotEmpty && _opQueue.last != '(') {
              _notation.add(_opQueue.removeLast());
            }
            var pairFound = _opQueue.isNotEmpty && _opQueue.last == '(';
            if (pairFound) {
              _opQueue.removeLast();
            } else {
              throw Exception(
                  'Expression is not valid. Missing breckets pair.');
            }
            continue;
          }
          while (_opQueue.isNotEmpty &&
              operations[_opQueue.last] >= operations[c]) {
            _notation.add(_opQueue.removeLast());
          }
          _opQueue.add(c);
        }
      } else {
        currentElement += c;
      }
    }
    if (currentElement.isNotEmpty) {
      _notation.add(currentElement);
    }
    while (_opQueue.isNotEmpty) {
      var op = _opQueue.removeLast();
      if (op.toString() == '(') {
        print('as');
        throw Exception('Expression is not valid. Missing breckets pair.');
      }
      _notation.add(op);
    }
    return _notation;
  }
}
