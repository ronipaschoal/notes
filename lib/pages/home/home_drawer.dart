import 'package:flutter/material.dart';
import 'package:notes/helpers/navigate.dart';
import 'package:notes/ui/colors.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: NtColors.darkGray,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 32.0),
            Container(
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
            ),
            TextButton(
              onPressed: () {
                NavigateHelper.close(context);
                NavigateHelper.to(context, NtPaths.note);
              },
              style: ButtonStyle(
                alignment: Alignment.center,
                overlayColor: MaterialStateProperty.all(NtColors.primary),
                shape: MaterialStateProperty.all(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0.0)),
                  ),
                ),
              ),
              child: const Text(
                'Nova nota',
                style: TextStyle(
                  color: NtColors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
