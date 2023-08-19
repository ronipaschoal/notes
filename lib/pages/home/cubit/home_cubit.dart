import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/cubit/note/note_cubit.dart';
import 'package:notes/helpers/debouncer.dart';
import 'package:notes/helpers/string.dart';
import 'package:notes/models/note/note_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final _debouncer = NtDebouncer(milliseconds: 500);
  final NoteCubit noteCubit;

  HomeCubit({required this.noteCubit}) : super(HomeInitialState());

  void changeViewType() {
    if (state is HomeSuccessState) {
      final successState = state as HomeSuccessState;
      emit(
        successState.copyWith(
          homeViewType: successState.homeViewType == HomeViewType.list
              ? HomeViewType.grid
              : HomeViewType.list,
        ),
      );
    }
  }

  void loadNoteList() {
    emit(HomeLoadingState());
    final noteList = noteCubit.noteList;
    emit(
      HomeSuccessState(noteList: noteList),
    );
  }

  void searchNote(String query) {
    _debouncer.run(() {
      if (state is HomeSuccessState) {
        final successState = state as HomeSuccessState;
        emit(
          successState.copyWith(
            noteList: noteCubit.noteList
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
