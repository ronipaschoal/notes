import 'dart:convert';

class NoteDto {
  String id;
  String title;
  String content;
  int priority;
  String created;

  NoteDto({
    required this.id,
    required this.title,
    required this.content,
    required this.priority,
    required this.created,
  });

  factory NoteDto.fromMap(Map<String, dynamic> map) {
    return NoteDto(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      priority: int.tryParse(map['priority']) ?? 0,
      created: DateTime.parse(map['created']).toString(),
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'content': content});
    result.addAll({'priority': priority});
    result.addAll({'created': created});

    return result;
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'NoteDto(id: $id, title: $title, content: $content, priority: $priority, created: $created)';
  }
}
