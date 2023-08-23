import 'package:flutter/material.dart';
import 'package:notes/helpers/navigate.dart';
import 'package:notes/ui/colors.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  Widget _icon() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: NtColors.primary, width: 0.5),
        ),
      ),
      child: const Image(
        height: 72.0,
        image: AssetImage('assets/icons/logo.png'),
      ),
    );
  }

  Widget _itemButton(BuildContext context, String text, String path) {
    return TextButton(
      onPressed: () => NavigateHelper.to(context, path),
      style: ButtonStyle(
        alignment: Alignment.center,
        overlayColor: MaterialStateProperty.all(NtColors.primary),
        shape: MaterialStateProperty.all(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(0.0)),
          ),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: NtColors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _build(BuildContext context) {
    return Drawer(
      backgroundColor: NtColors.darkGray,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 32.0),
          _icon(),
          _itemButton(context, 'Nova nota', NtPaths.note),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _build(context);
  }
}
