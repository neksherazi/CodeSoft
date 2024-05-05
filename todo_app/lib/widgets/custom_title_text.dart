import 'package:flutter/material.dart';

class CustomTitleText extends StatelessWidget {
  final double width;
  final double height;
  final String title;
  const CustomTitleText(
      {super.key,
      required this.width,
      required this.height,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 1,
            blurRadius: 8,
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
