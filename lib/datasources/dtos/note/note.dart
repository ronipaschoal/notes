import 'dart:convert';

class NoteDto {
  String id;
  String title;
  String content;
  int priority;
  String created;
  String? updated;

  NoteDto({
    required this.id,
    required this.title,
    required this.content,
    required this.priority,
    required this.created,
    this.updated,
  });

  factory NoteDto.fromMap(Map<String, dynamic> json) {
    return NoteDto(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      content: json['content'] as String? ?? '',
      priority: (json['priority'] as num?)?.toInt() ?? 0,
      created: DateTime.parse(json['created']).toString(),
      updated: DateTime.parse(json['updated']).toString(),
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'content': content});
    result.addAll({'priority': priority});
    result.addAll({'created': created});
    result.addAll({'updated': updated});

    return result;
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'NoteDto(id: $id, title: $title, content: $content, priority: $priority, created: $created, updated: $updated)';
  }
}
