import 'dart:async';

import 'package:flutter/Material.dart';

class NtDebouncer {
  final int milliseconds;
  Timer? _timer;

  NtDebouncer({required this.milliseconds});

  void run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
