import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/config/paths.dart';
import 'package:notes/cubit/note_list/note_list_cubit.dart';
import 'package:notes/pages/home/cubit/home_cubit.dart';
import 'package:notes/pages/home/home_screen.dart';
import 'package:notes/pages/note/cubit/note_cubit.dart';
import 'package:notes/pages/note/note_screen.dart';
import 'package:notes/pages/splash/splash_screen.dart';

class NtRoutes {
  NtRoutes._();

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

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

  static final List<RouteBase> _routes = [
    GoRoute(
      path: NtPaths.splash,
      pageBuilder: (_, __) {
        return _customTransitionPage(
          const SplashScreen(),
        );
      },
    ),
    GoRoute(
      path: NtPaths.home,
      pageBuilder: (_, __) {
        final recordCubit = _.read<NoteListCubit>();
        return _customTransitionPage(
          BlocProvider(
            create: (_) => HomeCubit(recordCubit: recordCubit),
            child: HomeScreen(),
          ),
        );
      },
    ),
    GoRoute(
      path: NtPaths.note,
      pageBuilder: (_, state) {
        final recordCubit = _.read<NoteListCubit>();
        final noteId = state.extra == null ? null : state.extra as String;
        return _customTransitionPage(
          BlocProvider(
            create: (_) => NoteCubit(recordCubit: recordCubit),
            child: NoteScreen(noteId: noteId),
          ),
        );
      },
    ),
  ];

  static final config = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: NtPaths.splash,
    routes: _routes,
  );
}
