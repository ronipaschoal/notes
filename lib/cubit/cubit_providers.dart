import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/config/http_client/http_client.dart';
import 'package:notes/cubit/connection/connection_cubit.dart';
import 'package:notes/cubit/note_list/note_list_cubit.dart';
import 'package:notes/datasources/cache/note/note_cache.dart';
import 'package:notes/datasources/repositories/note/note_repositorie.dart';
import 'package:notes/services/connection/connection_service.dart';

sealed class CubitProviders {
  static final noteRepository = NoteRepository(
    cache: NoteCache(),
    httpClient: HttpClient(Dio()),
  );

  static final List<BlocProvider> providers = [
    BlocProvider<AppConnectionCubit>(
      create: (_) => AppConnectionCubit(
        repository: noteRepository,
        connectionService: ConnectionService(connectivity: Connectivity()),
      )..init(),
    ),
    BlocProvider<NoteListCubit>(
      create: (_) => NoteListCubit(
        repository: noteRepository,
      ),
    ),
  ];
}
