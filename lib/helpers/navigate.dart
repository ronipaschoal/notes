import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

export 'package:notes/config/paths.dart';

class NtNavigate {
  NtNavigate._();

  static void to(BuildContext context, String path, {Object? extra}) {
    context.push(path, extra: extra);
  }

  static void close(BuildContext context, [dynamic result]) {
    context.pop(result);
  }
}