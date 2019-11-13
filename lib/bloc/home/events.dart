abstract class HomeEvent {

}

class PlotGraph extends HomeEvent {
  final String expression;
  PlotGraph({this.expression});
}