import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/helpers/navigate.dart';
import 'package:notes/models/note/note_model.dart';
import 'package:notes/pages/note/cubit/note_cubit.dart';
import 'package:notes/ui/colors.dart';
import 'package:notes/ui/scaffold.dart';
import 'package:notes/ui/widgets/text_field.dart';

class NoteScreen extends StatelessWidget {
  final String? noteId;

  NoteScreen({super.key, this.noteId});

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  void _save(BuildContext context, NoteModel note) {
    final cubit = context.read<NoteCubit>();

    cubit.add(
      note.copyWith(
        title: _titleController.text,
        content: _contentController.text,
      ),
    );
    NavigateHelper.close(context);
  }

  Widget _floatingButton(BuildContext context) {
    return BlocBuilder<NoteCubit, NoteState>(
      builder: (_, state) {
        return FloatingActionButton(
          onPressed: () => _save(context, state.note),
          foregroundColor: NtColors.lightGray,
          backgroundColor: NtColors.darkGray,
          tooltip: 'Salvar',
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.check),
          ),
        );
      },
    );
  }

  Widget _title(BuildContext context) {
    return BlocBuilder<NoteCubit, NoteState>(
      builder: (_, state) {
        final note = state.note;

        return NtTextfield(
          color: NtColors.white,
          cursorColor: NtColors.lightGray,
          hintText: note.title.isEmpty ? 'Adicione um titulo' : null,
          controller: _titleController..text = note.title,
        );
      },
    );
  }

  Widget _content(BuildContext context) {
    return BlocBuilder<NoteCubit, NoteState>(
      builder: (_, state) {
        final note = state.note;

        return NtTextfield(
          hintText: note.content.isEmpty ? 'Adicione uma nota' : null,
          controller: _contentController..text = note.content,
          keyboardType: TextInputType.multiline,
          borderColor: NtColors.white,
        );
      },
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _content(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NoteCubit>();
    cubit.get(noteId ?? '');

    return NtScaffold(
      title: _title(context),
      floatingButton: _floatingButton(context),
      child: _body(context),
    );
  }
}
