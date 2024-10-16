import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notes/helpers/navigate.dart';
import 'package:notes/models/note/note_model.dart';
import 'package:notes/pages/note/cubit/note_cubit.dart';
import 'package:notes/ui/colors.dart';
import 'package:notes/ui/scaffold.dart';
import 'package:notes/ui/widgets/text_field.dart';

class NoteScreen extends StatefulWidget {
  final String? noteId;

  const NoteScreen({super.key, this.noteId});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  late final _cubit = context.read<NoteCubit>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cubit.get(widget.noteId ?? '');
  }

  void _save(NoteModel note) async {
    final noteToSave = note.copyWith(
      title: _titleController.text,
      content: _contentController.text,
      updatedAt: null,
    );

    await _cubit.save(noteToSave);
    if (mounted) NavigateHelper.close(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteCubit, NoteState>(
      builder: (_, state) {
        final note = state.note;

        return NtScaffold(
          title: NtTextfield(
            color: NtColors.white,
            cursorColor: NtColors.lightGray,
            hintText: note.title.isEmpty ? 'Adicione um titulo' : null,
            controller: _titleController..text = note.title,
          ),
          color: note.priority?.color ?? NtColors.primary,
          floatingButton: FloatingActionButton(
            onPressed: () => _save(note),
            foregroundColor: NtColors.lightGray,
            backgroundColor: NtColors.darkGray,
            tooltip: 'Salvar',
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.check),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0),
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
              ),
              NtTextfield(
                hintText: note.content.isEmpty ? 'Adicione uma nota' : null,
                controller: _contentController..text = note.content,
                keyboardType: TextInputType.multiline,
                borderColor: NtColors.white,
              ),
            ],
          ),
        );
      },
    );
  }
}
