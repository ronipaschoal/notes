import 'package:notes/models/note/priority_enum.dart';

export 'package:notes/models/note/priority_enum.dart';

class NoteEntity {
  String? id;
  String title;
  String content;
  PriorityEnum priority;

  NoteEntity({
    this.id,
    required this.title,
    required this.content,
    required this.priority,
  });
}
