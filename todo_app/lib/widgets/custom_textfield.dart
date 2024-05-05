import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final int maxLines;
  final Function? onChanged;
  const CustomTextField(
      {super.key,
      this.controller,
      required this.maxLines,
      required this.labelText,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
