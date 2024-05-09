import 'package:flutter/material.dart';
import 'package:quote_app/screens/fav_screen.dart';
import 'package:quote_app/widgets/custom_text.dart';

class CustomAppbar extends StatelessWidget {
  final String titleText;
  const CustomAppbar({super.key, required this.titleText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 800,
      height: 60,
      child: Card(
        color: Colors.grey,
        elevation: 20,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                  );
                },
              ),
              CustomText(text: titleText),
              IconButton(
                color: Colors.grey,
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => const FavoriteQuotes()),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
