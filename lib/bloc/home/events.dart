abstract class HomeEvent {

}

class InitHome extends HomeEvent {}

class PlotGraph extends HomeEvent {
  final String expression;
  final double rangeStart;
  final double rangeEnd;
  PlotGraph({this.expression, this.rangeStart, this.rangeEnd});
}