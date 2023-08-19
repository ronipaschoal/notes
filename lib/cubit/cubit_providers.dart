import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/cubit/note_list/note_list_cubit.dart';
import 'package:notes/datasources/repositories/note/note_repositorie.dart';
import 'package:notes/services/note/note_service.dart';

class CubitProviders {
  CubitProviders._();

  static final List<BlocProvider> providers = [
    BlocProvider<NoteListCubit>(
      create: (_) => NoteListCubit(
        service: NoteService(
          repository: NoteRepository(),
        ),
      ),
    ),
  ];
}
