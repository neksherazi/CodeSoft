import 'package:flutter/material.dart';
import 'package:quote_app/widgets/custom_text.dart';

class CustomQuoteBox extends StatelessWidget {
  final Widget myWidget1;
  final Widget myWidget2;
  final String quote;
  final String author;
  const CustomQuoteBox(
      {super.key,
      required this.myWidget1,
      required this.myWidget2,
      required this.quote,
      required this.author});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: SizedBox(
          height: 418,
          child: Card(
              elevation: 20,
              color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    const CustomText(text: "Quote of the day"),
                    SizedBox(
                      height: 300,
                      width: 400,
                      child: Card(
                        elevation: 20,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "\"$quote\"",
                                style: const TextStyle(fontSize: 18),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "- $author",
                                style: const TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        myWidget1,
                        myWidget2,
                      ],
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
