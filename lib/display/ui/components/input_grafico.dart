import 'package:flutter/material.dart';

class InputGrafico extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final bool autocorrect;
  final String label;
  final String? Function(String?)? validator;

  const InputGrafico({
    super.key,
    required this.label,
    this.autocorrect = true,
    this.controller,
    this.textInputType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autocorrect: autocorrect,
      keyboardType: textInputType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
    );
  }
}
