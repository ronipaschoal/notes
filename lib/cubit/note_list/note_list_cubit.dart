import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/config/either.dart';
import 'package:notes/models/note/note_model.dart';
import 'package:notes/services/note/i_note_service.dart';

part 'note_list_state.dart';

class NoteListCubit extends Cubit<NoteListState> {
  final INoteService service;

  NoteListCubit({required this.service}) : super(NoteListState());

  List<NoteModel> get noteList => state.noteList;

  Future<void> _save(NoteModel note) async {
    final result = await service.createNote(note);

    switch (result) {
      case Success():
        emit(state.copyWith(noteList: [...state.noteList, note]));
        break;
      case Failure(:final exception):
        print(exception.toString());
        break;
    }
  }

  Future<void> _update(NoteModel note, int index) async {
    final result = await service.updateNote(note);

    switch (result) {
      case Success():
        state.noteList[index] = note;
        emit(state.copyWith(noteList: state.noteList));
        break;
      case Failure(:final exception):
        print(exception.toString());
        break;
    }
  }

  Future<void> save(NoteModel note) async {
    final index = state.noteList.indexWhere((element) => element.id == note.id);

    if (index > -1 && index < state.noteList.length) {
      await _update(note, index);
    } else {
      await _save(note);
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
        break;
      case Failure(:final exception):
        print(exception.toString());
        break;
    }
  }
}
