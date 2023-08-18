import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/models/note/note_model.dart';
import 'package:notes/services/note/i_note_service.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  final INoteService service;

  NoteCubit({required this.service}) : super(NoteState());

  List<NoteModel> get noteList => state.noteList;

  void add(NoteModel note) {
    emit(state.copyWith(noteList: [...state.noteList, note]));
  }

  void update(NoteModel note) {
    final index = state.noteList.indexWhere((element) => element.id == note.id);
    final noteList = state.noteList;
    noteList[index] = note;

    emit(state.copyWith(noteList: noteList));
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
    final noteList = await service.getNoteList();
    set(noteList);
  }
}
