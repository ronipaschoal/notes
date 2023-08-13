import 'package:flutter/material.dart';
import 'package:notes/datasources/repositories/note/note_mock.dart';
import 'package:notes/helpers/navigate.dart';
import 'package:notes/models/note/note_model.dart';
import 'package:notes/pages/home/home_drawer.dart';
import 'package:notes/ui/colors.dart';
import 'package:notes/ui/note_card.dart';
import 'package:notes/ui/scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget _list(List<NoteModel> noteList) {
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

  Widget _title() {
    return const Image(
      height: 80.0,
      image: AssetImage('assets/icons/logo.png'),
    );
  }

  Widget _floatingButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => NtNavigate.to(context, NtPaths.note),
      foregroundColor: NtColors.lightGray,
      backgroundColor: NtColors.darkGray,
      tooltip: 'Nova nota',
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Image(
          image: AssetImage('assets/icons/pencil.png'),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    final noteList = noteListMock;

    return Container(
      color: NtColors.lightGray,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _list(noteList),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NtScaffold(
      title: _title(),
      drawer: const HomeDrawer(),
      floatingButton: _floatingButton(context),
      child: _body(context),
    );
  }
}
