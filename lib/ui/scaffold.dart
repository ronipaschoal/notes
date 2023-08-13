import 'package:flutter/material.dart';
import 'package:notes/ui/colors.dart';

class NtScaffold extends StatelessWidget {
  final Widget? title;
  final Widget? drawer;
  final Widget? floatingButton;
  final Widget child;
  const NtScaffold({
    super.key,
    this.title,
    this.floatingButton,
    required this.child,
    this.drawer,
  });

  AppBar _appBar() {
    return AppBar(
      foregroundColor: NtColors.lightGray,
      backgroundColor: NtColors.darkGray,
      shape: const Border(
        bottom: BorderSide(
          color: NtColors.primary,
          width: 4.0,
        ),
      ),
      title: title,
    );
  }

  Scaffold _body(BuildContext context) {
    return Scaffold(
      appBar: title == null ? null : _appBar(),
      drawer: drawer,
      floatingActionButton: floatingButton,
      body: SingleChildScrollView(child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _body(context);
  }
}
