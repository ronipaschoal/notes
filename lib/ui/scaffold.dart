import 'package:flutter/material.dart';
import 'package:notes/ui/colors.dart';

class NtScaffold extends StatelessWidget {
  final String? title;
  final Widget child;
  const NtScaffold({super.key, this.title, required this.child});

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: NtColors.darkGray,
      iconTheme: const IconThemeData(color: NtColors.lightGray),
      shape: const Border(
        bottom: BorderSide(
          color: NtColors.primary,
          width: 4.0,
        ),
      ),
      title: Text(
        title!,
        style: const TextStyle(color: NtColors.lightGray),
      ),
    );
  }

  Scaffold _body() {
    return Scaffold(
      appBar: title == null ? null : _appBar(),
      body: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _body();
  }
}
