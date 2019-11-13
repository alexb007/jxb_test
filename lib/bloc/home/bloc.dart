import 'package:jxb_test/util/RpnParser.dart';

import 'states.dart';
import 'events.dart';
import 'package:bloc/bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => HomeUninitialized();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    final currentState = state;
    if (event is PlotGraph) {
      try {
        var notation = RpnParser().getNotation(event.expression);
        print(notation);
        yield HomeGraphPlotted(notation: notation.join(' '));
      } catch (ex) {
        print(ex);
        yield HomeExpressionError(errorText: ex);
      }
    }
  }
}
