import 'package:flutter/material.dart';
import 'package:notes/ui/colors.dart';
import 'package:notes/ui/connection_status_bar.dart';

class NtScaffold extends StatelessWidget {
  final Widget? title;
  final Color color;
  final Widget? drawer;
  final Widget? floatingButton;
  final Widget child;
  final List<Widget>? actions;

  const NtScaffold({
    super.key,
    this.title,
    this.color = NtColors.primary,
    this.floatingButton,
    required this.child,
    this.drawer,
    this.actions,
  });

  AppBar _appBar() {
    return AppBar(
      foregroundColor: NtColors.white,
      backgroundColor: NtColors.darkGray,
      shape: Border(
        bottom: BorderSide(
          color: color,
          width: 4.0,
        ),
      ),
      actions: actions,
      title: title,
    );
  }

  GestureDetector _unfocus(Widget child) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: child,
    );
  }

  SizedBox _usefulArea(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          const ConnectionStatusBar(),
          Expanded(child: child),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return _unfocus(
      Scaffold(
        backgroundColor: NtColors.white,
        appBar: title == null ? null : _appBar(),
        drawer: drawer,
        floatingActionButton: floatingButton,
        body: _usefulArea(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _body(context);
  }
}
