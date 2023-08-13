import 'package:flutter/material.dart';
import 'package:notes/pages/home/home_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Notes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: NtColors.darkGray,
        title: Text(
          widget.title,
          style: const TextStyle(color: NtColors.lightGray),
        ),
      ),
      body: const HomeScreen(),
    );
  }
}
