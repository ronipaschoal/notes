import 'package:flutter/painting.dart';
import 'package:notes/ui/colors.dart';

enum PriorityEnum {
  low(NtColors.low),
  medium(NtColors.medium),
  high(NtColors.high);

  const PriorityEnum(this.color);
  final Color color;
}
