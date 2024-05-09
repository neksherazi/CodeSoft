// packages
import 'dart:math';
import 'dart:convert';
import 'package:quote_app/helper/database_helper.dart';
import 'package:share/share.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
// widgets
import '../widgets/custom_appbar.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/custom_quote_box.dart';
import '../widgets/custom_icon_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //variables
  int randomNumber = 0;
  bool fav = false;
  List<dynamic> favList = [];
  List<dynamic> jsonData = [];

  // methods
  void generateRandomNumber() {
    Random random = Random();
    setState(() {
      randomNumber = random.nextInt(50);
    });
  }

  Future<void> loadJsonAsset() async {
    final String jsonString = await rootBundle.loadString('assets/quotes.json');
    var data = jsonDecode(jsonString);
    setState(() {
      jsonData = data;
    });
  }

  void _saveData() async {
    await DbHelper.insertData(jsonData[randomNumber]['quote']);
  }

  void shareQuote(String quote, String author) {
    Share.share('$quote\n- $author');
  }

  //loading jsonData then generating random number on app start
  @override
  void initState() {
    super.initState();
    loadJsonAsset().then((_) {
      generateRandomNumber();
    });
  }

  @override
  Widget build(BuildContext context) {
    // waiting for generating randomNumber and loading jsonData
    if (jsonData.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SafeArea(
      child: Scaffold(
        drawer: const CustomDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const CustomAppbar(titleText: "Home Screen"),
              CustomQuoteBox(
                quote: jsonData[randomNumber]['quote'],
                author: jsonData[randomNumber]['author'],
                myWidget1: CustomIconButton(
                  text: "Share",
                  icon: Icons.send,
                  color: Colors.white,
                  onTap: () {
                    shareQuote(jsonData[randomNumber]['quote'],
                        jsonData[randomNumber]['author']);
                  },
                ),
                myWidget2: CustomIconButton(
                  text: "Favorite",
                  icon: Icons.favorite,
                  color: fav ? Colors.red : Colors.white,
                  onTap: () {
                    setState(() {
                      _saveData();
                      fav = !fav;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
