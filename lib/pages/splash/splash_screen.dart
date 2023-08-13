import 'package:flutter/material.dart';
import 'package:notes/ui/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Widget _body() {
    return Container(
      padding: const EdgeInsets.all(80.0),
      color: NtColors.lightGray,
      child: const Image(
        image: AssetImage('assets/icons/logo.png'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes Splash',
      home: _body(),
    );
  }
}
