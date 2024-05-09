// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'db_helper.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

class UpdateData extends StatefulWidget {
  final int userId;
  const UpdateData({super.key, required this.userId});

  @override
  State<UpdateData> createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  void fetchData() async {
    Map<String, dynamic>? data = await DbHelper.getSingleData(widget.userId);
    if (data != null) {
      titleController.text = data['title'];
      descriptionController.text = data['description'];
    }
  }

  Future<bool> _updateData(BuildContext context) async {
    Map<String, dynamic> data = {
      'title': titleController.text,
      'description': descriptionController.text,
    };
    int id = await DbHelper.updateData(widget.userId, data);
    return id != 0; // Return true if the update was successful
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      title: const Text(
        "Update Task",
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        width: 200,
        height: 210,
        child: Column(
          children: [
            CustomTextField(
              controller: titleController,
              maxLines: 1,
              labelText: "Update title",
              hintText: "Enter title Text",
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: descriptionController,
              maxLines: 4,
              labelText: "Update descrption",
              hintText: "Enter decription text",
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
          name: "Update",
          myColor: Colors.green,
          onPressed: () async {
            bool success = await _updateData(context);
            Navigator.pop(context, success); // Return success value
          },
        )
      ],
    );
  }
}
