part of 'note_cubit.dart';

enum StateStatus {
  initial,
  loading,
  success,
  failure,
}

class NoteState {
  final List<NoteModel> noteList;
  final StateStatus status;

  NoteState({
    this.noteList = const [],
    this.status = StateStatus.initial,
  });

  NoteState copyWith({
    List<NoteModel>? noteList,
    StateStatus? status,
  }) {
    return NoteState(
      noteList: noteList ?? this.noteList,
      status: status ?? this.status,
    );
  }
}
