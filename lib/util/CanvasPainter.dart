import 'dart:math';

import 'package:flutter/material.dart';

class GraphPainter extends CustomPainter {
  SizeUtil get _sizeUtil {
    return SizeUtil();
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width > 1.0 && size.height > 1.0) {
//      SizeUtil.size = size;
    }
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blueAccent
      ..isAntiAlias = true;

    var path = Path();
    path.moveTo(_sizeUtil.width, _sizeUtil.height / 2);
    path.lineTo(0, _sizeUtil.height / 2);
    path.moveTo(_sizeUtil.width / 2, _sizeUtil.height);
    path.lineTo(_sizeUtil.width / 2, 0);
    canvas.drawPath(path, paint);
    canvas.save();
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class SizeUtil {
  static Map<String, SizeUtil> _keyValues = Map();

  Size _designSize;

  set designSize(Size size) {
    _designSize = size;
  }

  //logic size in device
  Size _logicalSize;

  //device pixel radio.

  get width => _logicalSize.width;

  get height => _logicalSize.height;

  set logicSize(Size size) => _logicalSize = size;

  //@param w is the design w;
  double getAxisX(double w) {
    return (w * width) / _designSize.width;
  }

// the y direction
  double getAxisY(double h) {
    return (h * height) / _designSize.height;
  }

  // diagonal direction value with design size s.
  double getAxisBoth(double s) {
    return s *
        sqrt((width * width + height * height) /
            (_designSize.width * _designSize.width +
                _designSize.height * _designSize.height));
  }
}
