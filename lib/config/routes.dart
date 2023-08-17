import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/config/paths.dart';
import 'package:notes/datasources/repositories/note/note_repositorie.dart';
import 'package:notes/models/note/note_model.dart';
import 'package:notes/pages/home/cubit/home_cubit.dart';
import 'package:notes/pages/home/home_screen.dart';
import 'package:notes/pages/note/note_screen.dart';
import 'package:notes/services/home/home_service.dart';

class NtRoutes {
  NtRoutes._();

  static CustomTransitionPage _customTransitionPage(Widget page) {
    return CustomTransitionPage(
      child: page,
      transitionsBuilder: (_, animation, __, child) {
        return SlideTransition(
          position: animation.drive(
            Tween(
              begin: const Offset(1.5, 0),
              end: Offset.zero,
            ),
          ),
          child: child,
        );
      },
    );
  }

  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: NtPaths.home,
        pageBuilder: (_, __) => _customTransitionPage(
          BlocProvider(
            create: (_) => HomeCubit(
              service: HomeService(repository: NoteRepository()),
            ),
            child: const HomeScreen(),
          ),
        ),
      ),
      GoRoute(
        path: NtPaths.note,
        pageBuilder: (_, state) {
          final note = state.extra == null ? null : state.extra as NoteModel;
          return _customTransitionPage(
            NoteScreen(note: note),
          );
        },
      ),
    ],
  );
}
