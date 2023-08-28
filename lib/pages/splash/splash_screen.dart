import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/cubit/note_list/note_list_cubit.dart';
import 'package:notes/helpers/navigate.dart';
import 'package:notes/ui/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<NoteListCubit>()
        .readNoteList()
        .then((_) => NavigateHelper.go(context, NtPaths.home));
  }

  Widget _body() {
    return Container(
      padding: const EdgeInsets.all(80.0),
      color: NtColors.black,
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
