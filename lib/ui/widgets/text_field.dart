import 'package:flutter/material.dart';
import 'package:notes/ui/colors.dart';

class NtTextfield extends StatelessWidget {
  final String? hintText;
  final Color? color;
  final Color? cursorColor;
  final Color? borderColor;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final ValueChanged? onChanged;
  final Widget? prefixIcon;

  const NtTextfield({
    super.key,
    this.hintText,
    this.color,
    this.cursorColor,
    this.borderColor,
    this.controller,
    this.keyboardType,
    this.onChanged,
    this.prefixIcon,
  });

  Widget _textField() {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: keyboardType == TextInputType.multiline ? null : 1,
      style: TextStyle(color: color ?? NtColors.darkGray),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: color ?? NtColors.darkGray),
        prefixIcon: prefixIcon,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor ?? NtColors.darkGray,
            width: 0.5,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(0.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor ?? NtColors.darkGray,
            width: 1.0,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(0.0)),
        ),
        contentPadding: const EdgeInsets.all(16.0),
      ),
      cursorColor: cursorColor ?? NtColors.darkGray,
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _textField();
  }
}
