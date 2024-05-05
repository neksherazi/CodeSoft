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
        foregroundColor: const MaterialStatePropertyAll(Colors.white),
        fixedSize: const MaterialStatePropertyAll(Size(92, 20)),
        shape: const MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
        ),
        backgroundColor: MaterialStatePropertyAll(myColor),
      ),
      child: Text(name),
    );
  }
}
