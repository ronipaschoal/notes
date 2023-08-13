import 'package:flutter/material.dart';
import 'package:notes/ui/colors.dart';

class NtScaffold extends StatelessWidget {
  final String? title;
  final Widget child;
  const NtScaffold({super.key, this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title == null
          ? null
          : AppBar(
              backgroundColor: NtColors.darkGray,
              iconTheme: const IconThemeData(color: NtColors.lightGray),
              title: Text(
                title!,
                style: const TextStyle(color: NtColors.lightGray),
              ),
            ),
      body: child,
    );
  }
}
