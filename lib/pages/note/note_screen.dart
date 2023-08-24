import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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

  void _save(BuildContext context, NoteModel note) async {
    final cubit = context.read<NoteCubit>();

    final noteToSave = note.copyWith(
      title: _titleController.text,
      content: _contentController.text,
    );

    await cubit.save(noteToSave);
    if (context.mounted) NavigateHelper.close(context);
  }

  Widget _floatingButton(BuildContext context, NoteModel note) {
    return FloatingActionButton(
      onPressed: () => _save(context, note),
      foregroundColor: NtColors.lightGray,
      backgroundColor: NtColors.darkGray,
      tooltip: 'Salvar',
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(Icons.check),
      ),
    );
  }

  Widget _title(BuildContext context, NoteModel note) {
    return NtTextfield(
      color: NtColors.white,
      cursorColor: NtColors.lightGray,
      hintText: note.title.isEmpty ? 'Adicione um titulo' : null,
      controller: _titleController..text = note.title,
    );
  }

  Widget _info(NoteModel note) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            DateFormat('dd/MM/yy HH:mm')
                .format(note.createdAt ?? DateTime.now())
                .toString(),
          ),
          Text(
            note.priority?.text ?? '',
            style: const TextStyle(color: NtColors.darkGray),
          ),
        ],
      ),
    );
  }

  Widget _content(NoteModel note) {
    return NtTextfield(
      hintText: note.content.isEmpty ? 'Adicione uma nota' : null,
      controller: _contentController..text = note.content,
      keyboardType: TextInputType.multiline,
      borderColor: NtColors.white,
    );
  }

  Widget _body(BuildContext context, NoteModel note) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _info(note),
        _content(note),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NoteCubit>();
    cubit.get(noteId ?? '');

    return BlocBuilder<NoteCubit, NoteState>(
      builder: (_, state) {
        final note = state.note;

        return NtScaffold(
          title: _title(context, note),
          color: note.priority?.color ?? NtColors.primary,
          floatingButton: _floatingButton(context, note),
          child: _body(context, note),
        );
      },
    );
  }
}
