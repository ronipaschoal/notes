part of 'home_cubit.dart';

sealed class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  final List<NoteModel> noteList;
  final List<NoteModel> noteListFiltered;

  HomeSuccessState({
    required this.noteList,
    required this.noteListFiltered,
  });

  HomeSuccessState copyWith({
    List<NoteModel>? noteList,
    List<NoteModel>? noteListFiltered,
  }) {
    return HomeSuccessState(
      noteList: noteList ?? this.noteList,
      noteListFiltered: noteListFiltered ?? this.noteList,
    );
  }
}

class HomeErrorState extends HomeState {
  final String error;
  HomeErrorState(this.error);
}
