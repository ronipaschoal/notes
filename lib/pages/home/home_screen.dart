import 'package:flutter/material.dart';
import 'package:notes/helpers/navigate.dart';
import 'package:notes/ui/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Container _body(BuildContext context) {
    return Container(
      color: NtColors.lightGray,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text('Home Screen'),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () => NtNavigate.to(context, NtPaths.note),
            child: const Text('note'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _body(context);
  }
}
