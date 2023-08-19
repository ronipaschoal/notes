import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/cubit/note_list/note_list_cubit.dart';
import 'package:notes/models/note/note_model.dart';
import 'package:uuid/uuid.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  final NoteListCubit recordCubit;

  NoteCubit({required this.recordCubit}) : super(NoteInitialState());

  void get(String id) {
    emit(NoteLoadingState());
    if (id.isEmpty) {
      const uuid = Uuid();
      emit(NoteSuccessState(note: NoteModel(id: uuid.v1())));
      return;
    }
    emit(NoteSuccessState(note: recordCubit.get(id)));
  }

  void add(NoteModel note) {
    emit(NoteLoadingState());
    recordCubit.save(note);
  }
}