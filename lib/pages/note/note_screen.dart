import 'package:flutter/material.dart';
import 'package:notes/ui/colors.dart';

class NoteScreen extends StatelessWidget {
  const NoteScreen({super.key});

  Widget _body() {
    return Container(
      color: NtColors.lightGray,
      child: const Center(
        child: Text('Home Screen'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _body();
  }
}
