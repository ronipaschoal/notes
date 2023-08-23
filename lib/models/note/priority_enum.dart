import 'package:flutter/painting.dart';
import 'package:notes/ui/colors.dart';

enum PriorityEnum {
  low('Baixa', NtColors.low),
  medium('Média', NtColors.medium),
  high('Alta', NtColors.high);

  const PriorityEnum(this.text, this.color);
  final String text;
  final Color color;
}
