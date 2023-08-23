import 'dart:convert';
import 'package:notes/models/note/note_entity.dart';

export 'package:notes/models/note/priority_enum.dart';

class NoteModel extends NoteEntity {
  const NoteModel({
    super.id,
    super.title = '',
    super.content = '',
    super.priority,
    super.createdAt,
  });

  factory NoteModel.fromEntity(NoteEntity entity) {
    return NoteModel(
      id: entity.id,
      title: entity.title,
      content: entity.content,
      priority: entity.priority,
      createdAt: entity.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'content': content});
    result.addAll({'priority': priority?.index ?? 0});
    result.addAll({'createdAt': createdAt.toString()});

    return result;
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      priority: map['priority'] ?? PriorityEnum.low,
      createdAt: map['createdAt'] ?? '',
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
    DateTime? createdAt,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      priority: priority ?? this.priority,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
