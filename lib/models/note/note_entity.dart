import 'package:notes/models/note/priority_enum.dart';

export 'package:notes/models/note/priority_enum.dart';

class NoteEntity {
  final String? id;
  final String title;
  final String content;
  final PriorityEnum priority;

  const NoteEntity({
    this.id,
    required this.title,
    required this.content,
    required this.priority,
  });
}
