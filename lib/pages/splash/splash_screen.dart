import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/cubit/note_list/note_list_cubit.dart';
import 'package:notes/helpers/navigate.dart';
import 'package:notes/ui/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void _init(BuildContext context) {
    context
        .read<NoteListCubit>()
        .loadNoteList()
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
    _init(context);

    return MaterialApp(
      title: 'Notes Splash',
      home: _body(),
    );
  }
}
