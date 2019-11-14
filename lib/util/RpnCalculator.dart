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

  bool get isNotOperator => !operations.containsKey(this);
}

class RpnCalculator {
  double _safeValue(dynamic elem, Map<String, double> variables) {
    if (elem is double)
      return elem;
    else if (variables.containsKey(elem)) {
      return variables[elem];
    } else
      throw Exception('Value for variable "$elem" is not provided');
  }

  double _doOperation(double elem1, double elem2, String operation) {
    switch (operation) {
      case '+':
        return elem1 + elem2;
      case '-':
        return elem1 - elem2;
      case '*':
        return elem1 * elem2;
      case '/':
        return elem1 / elem2;
    }
    throw Exception('Unexpected operation');
  }

  double calculate(Queue notation, {Map<String, double> variables}) {
    while(notation.length > 1) {
      var tempNotation = Queue();
      for (int index = notation.length - 1; index >= 0; index--) {
        if (notation.elementAt(index).toString().isOperator) {
          if (index <= 1)
            throw Exception('Bad notation');
          if (notation.elementAt(index - 1).toString().isNotOperator &&
              notation.elementAt(index - 2).toString().isNotOperator) {
            print(index);
            var res = _doOperation(
                _safeValue(notation.elementAt(index - 2), variables),
                _safeValue(notation.elementAt(index - 1), variables),
                notation.elementAt(index));
            tempNotation.addFirst(res);
            index -= 2;
          } else {
            tempNotation.addFirst(notation.elementAt(index));
          }
        } else {
            tempNotation.addFirst(notation.elementAt(index));
        }
      }
      notation = tempNotation;
      print(notation);
    }
    return notation.first;
  }
}
