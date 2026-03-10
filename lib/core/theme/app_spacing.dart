import 'package:flutter/widgets.dart';

class AppSpacing {
  AppSpacing._();

  // base spacing scale
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;
  static const double huge = 40;

  // common paddings
  static const EdgeInsets screenPadding = EdgeInsets.all(xl);

  static const EdgeInsets horizontalPadding =
      EdgeInsets.symmetric(horizontal: xl);

  static const EdgeInsets verticalPadding =
      EdgeInsets.symmetric(vertical: xl);

  static const EdgeInsets cardPadding =
      EdgeInsets.all(lg);

  static const EdgeInsets inputPadding =
      EdgeInsets.symmetric(horizontal: lg, vertical: md);

  // gaps
  static const SizedBox gapXs = SizedBox(height: xs);
  static const SizedBox gapSm = SizedBox(height: sm);
  static const SizedBox gapMd = SizedBox(height: md);
  static const SizedBox gapLg = SizedBox(height: lg);
  static const SizedBox gapXl = SizedBox(height: xl);
  static const SizedBox gapXxl = SizedBox(height: xxl);
  static const SizedBox gapXxxl = SizedBox(height: xxxl);

  // width gaps
  static const SizedBox gapWxs = SizedBox(width: xs);
  static const SizedBox gapWsm = SizedBox(width: sm);
  static const SizedBox gapWmd = SizedBox(width: md);
  static const SizedBox gapWlg = SizedBox(width: lg);
  static const SizedBox gapWxl = SizedBox(width: xl);
}