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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: NtColors.white,
        appBar: title == null
            ? null
            : AppBar(
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
              ),
        drawer: drawer,
        floatingActionButton: floatingButton,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              const ConnectionStatusBar(),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
