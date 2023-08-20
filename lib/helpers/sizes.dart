import 'package:flutter/material.dart';

sealed class SizesHelper {
  static Size sizeOf(BuildContext _) => MediaQuery.sizeOf(_);
  static EdgeInsets paddingOf(BuildContext _) => MediaQuery.paddingOf(_);
  static EdgeInsets viewInsetsOf(BuildContext _) => MediaQuery.viewInsetsOf(_);

  static double getUsableHeightAppBar(BuildContext context) {
    return getUsableHeight(context) - AppBar().preferredSize.height;
  }

  static double getUsableHeight(BuildContext context) {
    return sizeOf(context).height -
        paddingOf(context).top -
        paddingOf(context).bottom;
  }

  static double getWidgetHeight(GlobalKey key) {
    final renderBox = key.currentContext?.findRenderObject();
    return (renderBox == null) ? 0.0 : (renderBox as RenderBox).size.height;
  }
}
