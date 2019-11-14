import 'package:jxb_test/util/RpnCalculator.dart';
import 'package:jxb_test/util/RpnParser.dart';

import 'states.dart';
import 'events.dart';
import 'package:bloc/bloc.dart';
import 'dart:collection';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => HomeUninitialized();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is InitHome) {
      yield HomeWaitingExpression();
    }
    if (event is PlotGraph) {
      try {
        yield HomeLoading();
        var notation = RpnParser().getNotation(event.expression.replaceAll(' ', ''));
//        var res =
        var res = RpnCalculator().calculate(notation, variables: {'x': 4});
        yield HomeGraphPlotted(notation: notation.join(' '), res: res);
      } catch (ex) {
        yield HomeExpressionError(errorText: ex.toString());
      }
    }
  }

  @override
  Stream<HomeState> transformEvents(
      Stream<HomeEvent> events,
      Stream<HomeState> Function(HomeEvent event) next,
      ) {
    return super.transformEvents(
      (events as Observable<HomeEvent>).debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  void onTransition(Transition<HomeEvent, HomeState> transition) {
    print(transition);
  }
}
