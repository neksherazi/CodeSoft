// packages
import 'package:flutter/material.dart';
import '../helpers/update_user.dart';
import '../helpers/db_helper.dart';

// widgets
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/custom_title_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String title, description;
  late bool completed;
  List<Map<String, dynamic>> taskList = [];

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  void _saveData() async {
    final title = titleController.text;
    final description = descriptionController.text;
    int insertId = await DbHelper.insertData(title, description);
    debugPrint("$insertId");

    List<Map<String, dynamic>> updatedList = await DbHelper.getData();
    setState(() {
      taskList = updatedList;
    });
    titleController.clear();
    descriptionController.clear();
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  void _delete(int docId) async {
    await DbHelper.deleteData(docId);
    List<Map<String, dynamic>> updatedList = await DbHelper.getData();
    setState(() {
      taskList = updatedList;
    });
  }

  Future<void> _fetchData() async {
    List<Map<String, dynamic>> fetchedList = await DbHelper.getData();
    setState(() {
      taskList = fetchedList;
    });
  }

  void fetchData() async {
    List<Map<String, dynamic>> fetchedData = await DbHelper.getData();
    setState(() {
      taskList = fetchedData;
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  late double screenWidth;
  late double screenHeight;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: _buildUI(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return _addTask(
                  titleController,
                  descriptionController,
                  context,
                );
              },
            );
          },
          backgroundColor: Colors.white,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildUI() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.02,
        vertical: screenHeight * 0.02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomTitleText(
            width: screenWidth,
            height: 60,
            title: "Todo App",
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: screenWidth,
            height: screenHeight * 0.74,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 1,
                  blurRadius: 8,
                )
              ],
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    taskList[index]['title'],
                  ),
                  subtitle: Text(
                    taskList[index]['description'],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => UpdateData(
                                      userId: taskList[index]['id'],
                                    )).then((result) {
                              if (result == true) {
                                _fetchData();
                              }
                            });
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.green,
                          )),
                      IconButton(
                        onPressed: () {
                          _delete(taskList[index]['id']);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _addTask(
    TextEditingController titleController,
    TextEditingController descriptionController,
    BuildContext context,
  ) {
    return AlertDialog(
      title: const Text("Add Task"),
      content: SizedBox(
        width: 200,
        height: 207,
        child: Column(
          children: [
            CustomTextField(
              controller: titleController,
              maxLines: 1,
              labelText: "Add Title",
            ),
            const SizedBox(height: 6),
            CustomTextField(
              controller: descriptionController,
              maxLines: 4,
              labelText: "Add Descrption here",
            ),
          ],
        ),
      ),
      actions: [
        CustomButton(
          name: "Cancel",
          myColor: Colors.red,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        CustomButton(
          name: "Add",
          myColor: Colors.green,
          onPressed: _saveData,
        ),
      ],
    );
  }
}
