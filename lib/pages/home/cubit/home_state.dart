part of 'home_cubit.dart';

sealed class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  final List<NoteModel> noteList;

  HomeSuccessState({required this.noteList});

  HomeSuccessState copyWith({List<NoteModel>? noteList}) {
    return HomeSuccessState(noteList: noteList ?? this.noteList);
  }
}

class HomeErrorState extends HomeState {
  final String error;
  HomeErrorState(this.error);
}
