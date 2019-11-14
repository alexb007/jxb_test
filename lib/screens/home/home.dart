import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jxb_test/bloc/bloc.dart';
import 'package:jxb_test/util/CanvasPainter.dart';

class MyHomePage extends StatefulWidget {
  static const route = '/';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  HomeBloc _homeBloc;

  var _formKey = GlobalKey<FormState>();
  var _expressionController = TextEditingController();
  var _expression = '';
  var rangeStart = 0.0;
  var rangeEnd = 100.0;

  void _plot() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _homeBloc.add(PlotGraph(expression: _expression));
    }
  }

  @override
  void initState() {
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: _expressionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Colors.blueAccent, width: 1),
                ),
                hintText: 'x',
                hintStyle: TextStyle(fontStyle: FontStyle.italic),
                prefixText: 'y = ',
                prefixStyle: TextStyle(fontStyle: FontStyle.italic),
              ),
              validator: (value) {
                if (value.isEmpty) return 'Enter the expression';
                return null;
              },
              onSaved: (value) {
                setState(() {
                  _expression = value;
                });
              },
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide:
                            BorderSide(color: Colors.blueAccent, width: 1),
                      ),
                      hintText: 'Range start',

                      hintStyle: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    validator: (value) {
                      if (value.isEmpty) return 'Start range';
                      if (double.parse(value) > rangeEnd)
                        return 'Must be less than  $rangeEnd';
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        rangeStart = double.parse(value);
                      });
                    },
                  ),
                  flex: 2,
                ),
                SizedBox(width: 8),
                Flexible(
                  flex: 2,
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide:
                            BorderSide(color: Colors.blueAccent, width: 1),
                      ),
                      hintText: 'Range end',
                      hintStyle: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    validator: (value) {
                      if (value.isEmpty) return 'Enter the end range';
                      if (double.parse(value) > rangeEnd)
                        return 'Must be greater than  $rangeStart';
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        rangeEnd = double.parse(value);
                      });
                    },
                  ),
                ),
                SizedBox(width: 8),
                Flexible(
                  flex: 1,
                  child: MaterialButton(
                    color: Colors.blueAccent,
                    child: Text('Plot'),
                    onPressed: _plot,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: BlocBuilder<HomeBloc, HomeState>(
                  bloc: _homeBloc,
                  builder: (context, state) {
                    print(state);
                    if (state is HomeGraphPlotted) {
                      return Column(
                        children: <Widget>[
                          Text('${state.notation}\n y=${state.res}'),
                          CustomPaint(
                            painter: GraphPainter(),
                          )
                        ],
                      );
                    }
                    if (state is HomeExpressionError) {
                      return Text(state.errorText);
                    }
                    if (state is HomeWaitingExpression) {
                      return Text('Waiting to expression');
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
