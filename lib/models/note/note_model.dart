import 'dart:convert';
import 'package:notes/models/note/note_entity.dart';

export 'package:notes/models/note/priority_enum.dart';

class NoteModel extends NoteEntity {
  const NoteModel({
    super.id,
    super.title = '',
    super.content = '',
    super.priority = PriorityEnum.low,
    super.createdAt,
    super.updatedAt,
  });

  factory NoteModel.fromEntity(NoteEntity entity) {
    return NoteModel(
      id: entity.id,
      title: entity.title,
      content: entity.content,
      priority: entity.priority,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'content': content});
    result.addAll({'priority': priority?.index ?? 0});
    result.addAll({'createdAt': createdAt.toString()});
    result.addAll({'updatedAt': updatedAt?.toString() ?? ''});

    return result;
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      priority: PriorityEnum.values[map['priority'] ?? 0],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: map['updatedAt'] == null || map['updatedAt'] == '' //
          ? null
          : DateTime.parse(map['updatedAt']),
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
    DateTime? updatedAt,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      priority: priority ?? this.priority,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt,
    );
  }

  @override
  String toString() {
    return 'NoteModel(id: $id, title: $title, content: $content, priority: $priority, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
