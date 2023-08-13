import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes/config/routes.dart';
import 'package:notes/pages/splash/splash_screen.dart';
import 'package:notes/ui/colors.dart';

void main() {
  runApp(const SplashScreen());
  Future.delayed(
    const Duration(seconds: 2),
    () => runApp(const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Notes';

  Widget get _body {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp.router(
      title: _title,
      debugShowCheckedModeBanner: false,
      routerConfig: NtRoutes.router,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: NtColors.primary),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _body;
}
