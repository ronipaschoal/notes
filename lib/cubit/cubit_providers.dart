import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/cubit/note/note_cubit.dart';
import 'package:notes/datasources/repositories/note/note_repositorie.dart';
import 'package:notes/services/note/note_service.dart';

class CubitProviders {
  CubitProviders._();

  static final List<BlocProvider> providers = [
    BlocProvider<NoteCubit>(
      create: (_) =>
          NoteCubit(service: NoteService(repository: NoteRepository())),
    ),
  ];
}
