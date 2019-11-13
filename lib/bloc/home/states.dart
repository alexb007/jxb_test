import 'dart:ui';

abstract class HomeState {}

class HomeUninitialized extends HomeState {}

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

  HomeGraphPlotted({this.graph, this.notation});

  HomeGraphPlotted copyWith({
    Image graph,
    String notation,
  }) {
    return HomeGraphPlotted(
      graph: graph ?? this.graph,
      notation: notation ?? this.notation,
    );
  }
}
