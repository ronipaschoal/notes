part of 'note_cubit.dart';

sealed class NoteState {
  NoteModel note;

  NoteState({
    this.note = const NoteModel(),
  });
}

class NoteInitialState extends NoteState {
  NoteInitialState();
}

class NoteLoadingState extends NoteState {
  NoteLoadingState();
}

class NoteSuccessState extends NoteState {
  NoteSuccessState({
    required super.note,
  });

  NoteSuccessState copyWith({
    NoteModel? note,
  }) {
    return NoteSuccessState(
      note: note ?? super.note,
    );
  }
}

class NoteErrorState extends NoteState {
  final String error;
  NoteErrorState(this.error);
}
