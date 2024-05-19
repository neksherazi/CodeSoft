import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color myColor;
  final void Function() onPressed;
  final String name;
  const CustomButton(
      {super.key,
      required this.name,
      required this.myColor,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        foregroundColor: const WidgetStatePropertyAll(Colors.white),
        fixedSize: const WidgetStatePropertyAll(Size(92, 20)),
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
        ),
        backgroundColor: WidgetStatePropertyAll(myColor),
      ),
      child: Text(name),
    );
  }
}
