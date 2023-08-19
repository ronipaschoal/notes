import 'package:flutter/material.dart';
import 'package:notes/models/note/note_model.dart';
import 'package:notes/ui/scaffold.dart';

class NoteScreen extends StatelessWidget {
  final NoteModel? note;
  const NoteScreen({super.key, this.note});

  Widget _body(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          note == null
              ? const Text('Adicione uma nota')
              : Text(note?.content ?? ''),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NtScaffold(
      title: Text(
        note?.title ?? 'Nova nota',
        style: const TextStyle(fontSize: 16.0),
      ),
      child: _body(context),
    );
  }
}
