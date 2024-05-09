import 'package:flutter/material.dart';
import 'package:quote_app/helper/database_helper.dart';
import 'package:quote_app/screens/home_screen.dart';
import '../widgets/custom_text.dart';

class FavoriteQuotes extends StatefulWidget {
  const FavoriteQuotes({super.key});

  @override
  State<FavoriteQuotes> createState() => _FavoriteQuotesState();
}

class _FavoriteQuotesState extends State<FavoriteQuotes> {
  late double screenWidth;
  late double screenHeight;
  List<Map<String, dynamic>> favList = [];

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  void _fetchData() async {
    List<Map<String, dynamic>> fetchedData = await DbHelper.getData();
    setState(() {
      favList = fetchedData;
    });
  }

  void _deleteData(int id) async {
    DbHelper.deleteData(id);
    List<Map<String, dynamic>> fetchedData = await DbHelper.getData();
    setState(() {
      favList = fetchedData;
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _customFavAppBar(context),
              const SizedBox(height: 10),
              SizedBox(
                width: screenWidth,
                height: screenHeight * 0.855,
                child: Card(
                  color: Colors.grey,
                  elevation: 20,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: _customListTile(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _customListTile() {
    return ListView.builder(
      itemCount: favList.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.white,
          elevation: 20,
          child: ListTile(
            title: Text(
              favList[index]['author'],
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
            trailing: IconButton(
              onPressed: () {
                _deleteData(favList[index]['id']);
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _customFavAppBar(BuildContext context) {
    return SizedBox(
      width: screenWidth,
      height: 60,
      child: Card(
        color: Colors.grey,
        elevation: 20,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.keyboard_backspace_rounded,
                    color: Colors.white,
                  )),
              const Spacer(),
              const CustomText(text: "Favorite Quotes"),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
