import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/helpers/debouncer.dart';
import 'package:notes/helpers/string.dart';
import 'package:notes/models/note/note_model.dart';
import 'package:notes/services/home/i_home_service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final _debouncer = NtDebouncer(milliseconds: 500);
  final IHomeService service;

  HomeCubit({required this.service}) : super(HomeInitialState());

  void loadNoteList() async {
    emit(HomeLoadingState());
    final noteList = await service.getNoteList();
    emit(
      HomeSuccessState(
        noteList: noteList,
        noteListFiltered: noteList,
      ),
    );
  }

  void searchNote(String query) async {
    _debouncer.run(() async {
      if (state is HomeSuccessState) {
        final successState = state as HomeSuccessState;
        emit(
          successState.copyWith(
            noteListFiltered: successState.noteList
                .where(
                  (note) =>
                      note.title
                          .removeDiatrics()
                          .toLowerCase()
                          .contains(query.removeDiatrics().toLowerCase()) ||
                      note.content
                          .removeDiatrics()
                          .toLowerCase()
                          .contains(query.removeDiatrics().toLowerCase()),
                )
                .toList(),
          ),
        );
      }
    });
  }
}
