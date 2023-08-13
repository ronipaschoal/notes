import 'package:flutter/material.dart';
import 'package:notes/helpers/navigate.dart';
import 'package:notes/ui/colors.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  TextButton _itemButton(BuildContext context, String text, String path) {
    return TextButton(
      onPressed: () => NtNavigate.to(context, path),
      style: ButtonStyle(
        alignment: Alignment.bottomLeft,
        overlayColor: MaterialStateProperty.all(NtColors.primary),
        shape: MaterialStateProperty.all(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(0.0)),
          ),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(color: NtColors.white),
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
