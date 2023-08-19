import 'package:flutter/material.dart';
import 'package:notes/ui/colors.dart';

class NtScaffold extends StatelessWidget {
  final Widget? title;
  final Widget? drawer;
  final Widget? floatingButton;
  final Widget child;
  final List<Widget>? actions;

  const NtScaffold({
    super.key,
    this.title,
    this.floatingButton,
    required this.child,
    this.drawer,
    this.actions,
  });

  AppBar _appBar() {
    return AppBar(
      foregroundColor: NtColors.white,
      backgroundColor: NtColors.darkGray,
      shape: const Border(
        bottom: BorderSide(
          color: NtColors.primary,
          width: 2.0,
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

  Widget _body(BuildContext context) {
    return _unfocus(
      Scaffold(
        backgroundColor: NtColors.white,
        appBar: title == null ? null : _appBar(),
        drawer: drawer,
        floatingActionButton: floatingButton,
        body: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _body(context);
  }
}
