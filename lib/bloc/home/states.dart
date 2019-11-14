import 'dart:ui';

abstract class HomeState {}

class HomeUninitialized extends HomeState {}
class HomeWaitingExpression extends HomeState {}
class HomeLoading extends HomeState {}

class HomeExpressionError extends HomeState {
  final String errorText;

  HomeExpressionError({this.errorText});

  HomeExpressionError copyWith({
    String errorText,
  }) {
    return HomeExpressionError(
      errorText: errorText ?? this.errorText,
    );
  }
}

class HomeGraphPlotted extends HomeState {
  final Image graph;
  final String notation;
  final double res;

  HomeGraphPlotted({this.graph, this.notation, this.res});

  HomeGraphPlotted copyWith({
    Image graph,
    String notation,
    double res,
  }) {
    return HomeGraphPlotted(
      graph: graph ?? this.graph,
      notation: notation ?? this.notation,
      res: res ?? this.res
    );
  }
}
