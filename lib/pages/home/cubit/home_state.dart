part of 'home_cubit.dart';

enum HomeViewType { list, grid }

sealed class HomeState {
  HomeViewType homeViewType;

  HomeState({this.homeViewType = HomeViewType.list});
}

class HomeInitialState extends HomeState {
  HomeInitialState();
}

class HomeLoadingState extends HomeState {
  HomeLoadingState();
}

class HomeSuccessState extends HomeState {
  final List<NoteModel> noteList;

  HomeSuccessState({
    super.homeViewType,
    required this.noteList,
  });

  HomeSuccessState copyWith({
    HomeViewType? homeViewType,
    List<NoteModel>? noteList,
  }) {
    return HomeSuccessState(
      homeViewType: homeViewType ?? super.homeViewType,
      noteList: noteList ?? this.noteList,
    );
  }
}

class HomeErrorState extends HomeState {
  final String error;
  HomeErrorState(this.error);
}
