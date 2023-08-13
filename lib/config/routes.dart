import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/config/paths.dart';
import 'package:notes/pages/home/home_screen.dart';
import 'package:notes/pages/note/note_screen.dart';
import 'package:notes/ui/scaffold.dart';

class NtRoutes {
  NtRoutes._();

  static CustomTransitionPage _customTransitionPage(String title, Widget page) {
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
          child: NtScaffold(title: title, child: child),
        );
      },
    );
  }

  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: NtPaths.home,
        pageBuilder: (_, __) => _customTransitionPage(
          'Notes',
          const HomeScreen(),
        ),
      ),
      GoRoute(
        path: NtPaths.note,
        pageBuilder: (_, __) => _customTransitionPage(
          'Note',
          const NoteScreen(),
        ),
      ),
    ],
  );
}
