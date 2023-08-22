import 'dart:async';

import 'package:flutter/Material.dart';

class DebouncerHelper {
  final int milliseconds;
  Timer? _timer;

  DebouncerHelper({required this.milliseconds});

  void run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
