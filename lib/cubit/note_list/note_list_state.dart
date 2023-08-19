part of 'note_list_cubit.dart';

class NoteListState {
  final List<NoteModel> noteList;

  NoteListState({
    this.noteList = const [],
  });

  NoteListState copyWith({
    List<NoteModel>? noteList,
  }) {
    return NoteListState(
      noteList: noteList ?? this.noteList,
    );
  }
}
