import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/config/either.dart';
import 'package:notes/datasources/repositories/note/i_note_repositorie.dart';
import 'package:notes/models/note/note_model.dart';

part 'note_list_state.dart';

class NoteListCubit extends Cubit<NoteListState> {
  final INoteRepository repository;

  NoteListCubit({required this.repository}) : super(NoteListState());

  List<NoteModel> get noteList => state.noteList;

  Future<void> _create(NoteModel note) async {
    final noteList = [...state.noteList, note];
    await repository.saveNoteList(noteList);
    final result = await repository.createNote(note);

    switch (result) {
      case Success():
        await readNoteList();
        break;
      case Failure():
        break;
    }
    emit(state.copyWith(noteList: noteList));
  }

  Future<void> readNoteList() async {
    final noteList = await repository.readNoteList();
    set(noteList);
  }

  Future<void> _update(NoteModel note, int index) async {
    final noteList = state.noteList;
    noteList[index] = note;
    await repository.saveNoteList(noteList);
    final result = await repository.updateNote(note);

    switch (result) {
      case Success():
        await readNoteList();
        break;
      case Failure():
        break;
    }
    emit(state.copyWith(noteList: noteList));
  }

  void delete(NoteModel note) async {
    final noteList = state.noteList;
    final result = await repository.deleteNote(note);

    switch (result) {
      case Success():
        noteList.removeWhere((element) => element.id == note.id);
        break;
      case Failure():
        print('delete Failure:');
        break;
    }

    emit(state.copyWith(noteList: noteList));
  }

  Future<void> save(NoteModel note) async {
    await sync();
    final index = _getNoteIndex(note);
    (index == -1) // -1 = not found
        ? await _create(note)
        : await _update(note, index);
  }

  Future<void> sync() async => repository.sync();

  int _getNoteIndex(NoteModel note) =>
      state.noteList.indexWhere((element) => element.id == note.id);

  NoteModel get(String id) {
    return state.noteList.firstWhere((element) => element.id == id);
  }

  void clear() {
    emit(state.copyWith(noteList: []));
  }

  void set(List<NoteModel> noteList) {
    emit(state.copyWith(noteList: noteList));
  }
}
