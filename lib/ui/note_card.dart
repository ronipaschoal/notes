import 'package:flutter/material.dart';
import 'package:notes/helpers/navigate.dart';
import 'package:notes/models/note/note_model.dart';
import 'package:notes/ui/colors.dart';

class NtNoteCard extends StatelessWidget {
  final NoteModel note;
  const NtNoteCard({super.key, required this.note});

  Widget _priorityColor() {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      decoration: BoxDecoration(
        color: note.priority.color,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
    );
  }

  Widget _row(Widget child) {
    return Stack(
      children: [
        _priorityColor(),
        Container(
          height: double.maxFinite,
          margin: const EdgeInsets.only(
            left: 8.0,
            top: 0.4,
            right: 2.0,
            bottom: 0.4,
          ),
          decoration: const BoxDecoration(
            color: NtColors.white,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Row(
            children: [
              const SizedBox(width: 16.0),
              Text(note.title),
            ],
          ),
        ),
      ],
    );
  }

  Widget _container(Widget child) {
    return Container(
      height: 56.0,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: NtColors.lightGray,
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        boxShadow: [
          BoxShadow(
            color: NtColors.midGray.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
          ),
        ],
      ),
      child: _row(child),
    );
  }

  Widget _gestureDetector(BuildContext context, Widget child) {
    return GestureDetector(
      child: _container(child),
      onTap: () => NtNavigate.to(context, NtPaths.note, extra: note),
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
