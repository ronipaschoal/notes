import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/datasources/either.dart';
import 'package:notes/models/note/note_model.dart';
import 'package:notes/services/note/i_note_service.dart';

part 'note_list_state.dart';

class NoteListCubit extends Cubit<NoteListState> {
  final INoteService service;

  NoteListCubit({required this.service}) : super(NoteListState());

  List<NoteModel> get noteList => state.noteList;

  void _add(NoteModel note) {
    emit(state.copyWith(noteList: [...state.noteList, note]));
  }

  void _update(NoteModel note, int index) {
    final noteList = state.noteList;
    noteList[index] = note;

    emit(state.copyWith(noteList: noteList));
  }

  void save(NoteModel note) {
    final index = state.noteList.indexWhere((element) => element.id == note.id);

    if (index > -1 && index < state.noteList.length) {
      _update(note, index);
    } else {
      _add(note);
    }
  }

  NoteModel get(String id) {
    return state.noteList.firstWhere((element) => element.id == id);
  }

  void delete(NoteModel note) {
    final noteList = state.noteList;
    noteList.removeWhere((element) => element.id == note.id);

    emit(state.copyWith(noteList: noteList));
  }

  void clear() {
    emit(state.copyWith(noteList: []));
  }

  void set(List<NoteModel> noteList) {
    emit(state.copyWith(noteList: noteList));
  }

  Future<void> loadNoteList() async {
    final result = await service.getNoteList();

    switch (result) {
      case Success(value: final noteList):
        set(noteList);
      case Failure(:final exception):
        print(exception.toString());
    }
  }
}
