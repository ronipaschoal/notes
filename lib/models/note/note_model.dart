import 'dart:convert';
import 'package:notes/models/note/note_entity.dart';

export 'package:notes/models/note/priority_enum.dart';

class NoteModel extends NoteEntity {
  const NoteModel({
    super.id,
    super.title = '',
    super.content = '',
    super.priority = PriorityEnum.low,
  });

  factory NoteModel.fromEntity(NoteEntity entity) {
    return NoteModel(
      id: entity.id,
      title: entity.title,
      content: entity.content,
      priority: entity.priority,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'content': content});
    result.addAll({'priority': priority});

    return result;
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      priority: map['priority'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory NoteModel.fromJson(String source) =>
      NoteModel.fromMap(json.decode(source));

  NoteModel copyWith({
    String? id,
    String? title,
    String? content,
    PriorityEnum? priority,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      priority: priority ?? this.priority,
    );
  }
}
