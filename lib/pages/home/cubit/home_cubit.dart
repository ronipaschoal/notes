import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/cubit/note_list/note_list_cubit.dart';
import 'package:notes/helpers/debouncer.dart';
import 'package:notes/helpers/string.dart';
import 'package:notes/models/note/note_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final _debouncer = DebouncerHelper(milliseconds: 500);
  final NoteListCubit recordCubit;

  HomeCubit({required this.recordCubit}) : super(HomeInitialState());

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

    recordCubit.stream
        .listen((_) => emit(HomeSuccessState(noteList: _.noteList)));

    emit(HomeSuccessState(noteList: recordCubit.noteList));
  }

  bool _test(String attributes, String query) {
    return attributes
        .removeDiatrics()
        .toLowerCase()
        .contains(query.removeDiatrics().toLowerCase());
  }

  List<NoteModel> _filter(String query) {
    return recordCubit.noteList
        .where((note) => _test(note.title, query) || _test(note.content, query))
        .toList();
  }

  void searchNote(String query) {
    if (state is HomeSuccessState) {
      _debouncer.run(() {
        final successState = state as HomeSuccessState;
        emit(successState.copyWith(noteList: _filter(query)));
      });
    }
  }
}
