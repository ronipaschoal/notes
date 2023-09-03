import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/config/either.dart';
import 'package:notes/datasources/cache/note/i_note_cache.dart';
import 'package:notes/datasources/repositories/note/i_note_repositorie.dart';
import 'package:notes/models/note/note_model.dart';

part 'note_list_state.dart';

class NoteListCubit extends Cubit<NoteListState> {
  final INoteRepository repository;
  final INoteCache cache;

  NoteListCubit({
    required this.repository,
    required this.cache,
  }) : super(NoteListState());

  List<NoteModel> get noteList => state.noteList;

  Future<void> _create(NoteModel note, [bool getList = true]) async {
    emit(state.copyWith(noteList: [...state.noteList, note]));
    await cache.saveNoteList(noteList);
    final result = await repository.createNote(note);

    switch (result) {
      case Success():
        if (getList) await readNoteList();
        break;
      case Failure():
        break;
    }
  }

  Future<void> readNoteList() async {
    final result = await repository.readNoteList();

    switch (result) {
      case Success(value: final noteList):
        await cache.saveNoteList(noteList);
        set(noteList);
        break;
      case Failure():
        final noteList = await cache.getNoteList();
        set(noteList);
        break;
    }
  }

  Future<void> _update(NoteModel note, int index, [bool getList = true]) async {
    state.noteList[index] = note;
    emit(state.copyWith(noteList: state.noteList));
    await cache.saveNoteList(noteList);
    final result = await repository.updateNote(note);

    switch (result) {
      case Success():
        if (getList) await readNoteList();
        break;
      case Failure():
        break;
    }
  }

  void delete(NoteModel note) async {
    final result = await repository.deleteNote(note);

    switch (result) {
      case Success():
        state.noteList.removeWhere((element) => element.id == note.id);
        emit(state.copyWith(noteList: state.noteList));
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

  Future<void> sync() async {
    final noteList = await cache.getNoteListToSync();

    noteList.map((note) async {
      final index = _getNoteIndex(note);
      await _update(note, index, false);
    }).toList();
  }

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
