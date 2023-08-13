import 'package:flutter/material.dart';
import 'package:notes/datasources/repositories/note/note_mock.dart';
import 'package:notes/helpers/navigate.dart';
import 'package:notes/models/note/note_model.dart';
import 'package:notes/ui/colors.dart';
import 'package:notes/ui/note_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  ListView _list(List<NoteModel> noteList) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: noteList.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8.0),
      itemBuilder: (_, index) => NtNoteCard(
        note: noteList[index],
      ),
    );
  }

  ElevatedButton _addNote(BuildContext context) {
    return ElevatedButton(
      onPressed: () => NtNavigate.to(context, NtPaths.note),
      child: const Text('Nova'),
    );
  }

  Container _body(BuildContext context) {
    final noteList = noteListMock;

    return Container(
      color: NtColors.lightGray,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _list(noteList),
              const SizedBox(height: 8.0),
              _addNote(context)
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _body(context);
  }
}
