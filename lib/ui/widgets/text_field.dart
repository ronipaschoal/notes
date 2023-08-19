import 'package:flutter/material.dart';
import 'package:notes/ui/colors.dart';

class NtTextfield extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final ValueChanged? onChanged;
  final Widget? prefixIcon;

  const NtTextfield({
    super.key,
    this.hintText,
    this.controller,
    this.onChanged,
    this.prefixIcon,
  });

  Widget _textField() {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: NtColors.midGray, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(0.0)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: NtColors.darkGray, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(0.0)),
        ),
        contentPadding: const EdgeInsets.all(16.0),
      ),
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _textField();
  }
}
