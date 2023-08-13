import 'package:flutter/material.dart';
import 'package:notes/helpers/navigate.dart';
import 'package:notes/models/note/note_model.dart';
import 'package:notes/ui/colors.dart';

class NtNoteCard extends StatelessWidget {
  final NoteModel note;
  const NtNoteCard({super.key, required this.note});

  Widget _row(Widget child) {
    return Row(
      children: [
        Container(
          width: 8.0,
          height: double.maxFinite,
          color: note.priority.color,
        ),
        const SizedBox(width: 16.0),
        Text(note.title),
      ],
    );
  }

  Widget _container(Widget child) {
    return Container(
      height: 56.0,
      width: double.maxFinite,
      padding: const EdgeInsets.only(right: 16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        border: Border.fromBorderSide(
          BorderSide(color: NtColors.midGray, width: 1.0),
        ),
      ),
      child: _row(child),
    );
  }

  Widget _gestureDetector(BuildContext context, Widget child) {
    return GestureDetector(
      child: _container(child),
      onTap: () => NtNavigate.to(context, NtPaths.note),
    );
  }

  Widget _body(BuildContext context) {
    return _gestureDetector(
      context,
      Text(note.title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _body(context);
  }
}
