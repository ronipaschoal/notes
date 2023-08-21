class NoteDto {
  String id;
  String title;
  String content;
  int priority;

  NoteDto({
    required this.id,
    required this.title,
    required this.content,
    required this.priority,
  });

  factory NoteDto.fromMap(Map<String, dynamic> map) {
    return NoteDto(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      priority: int.tryParse(map['priority']) ?? 0,
    );
  }

  @override
  String toString() {
    return 'NoteDto(id: $id, title: $title, content: $content, priority: $priority)';
  }
}
