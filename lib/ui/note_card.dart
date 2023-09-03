import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/models/note/note_model.dart';
import 'package:notes/ui/colors.dart';

class NtNoteCard extends StatelessWidget {
  final NoteModel note;
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;

  const NtNoteCard({
    super.key,
    required this.note,
    this.onTap,
    this.onLongPress,
  });

  Widget _priorityColor() {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      decoration: BoxDecoration(
        color: note.priority?.color,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
    );
  }

  Widget _content() {
    return Container(
      height: double.maxFinite,
      margin: const EdgeInsets.only(
        left: 8.0,
        top: 1.0,
        right: 2.0,
        bottom: 1.0,
      ),
      decoration: const BoxDecoration(
        color: NtColors.white,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(note.title),
                Text(
                  DateFormat('dd/MM/yy HH:mm')
                      .format(note.createdAt ?? DateTime.now())
                      .toString(),
                  style: const TextStyle(fontSize: 12.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(Widget child) {
    return Stack(
      children: [
        _priorityColor(),
        _content(),
      ],
    );
  }

  Widget _container(Widget child) {
    return Container(
      height: 56.0,
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        boxShadow: [
          BoxShadow(
            color: NtColors.midGray.withOpacity(0.5),
            blurRadius: 1,
            spreadRadius: 1,
          ),
        ],
      ),
      child: _row(child),
    );
  }

  Widget _body() {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: _container(Text(note.title)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _body();
  }
}
