import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class taskPage extends StatefulWidget {
  const taskPage({super.key});

  @override
  State<taskPage> createState() => _taskPageState();
}

class _taskPageState extends State<taskPage> {

  final titleController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  Future<void> uploadToDb() async {
    try {
      final data =
          await FirebaseFirestore.instance.collection("Daily Tasks").add({
        "Task Name": titleController.text.trim(),
        "Date": "11-11-2003",
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Add Tasks"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              child: TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    hintText: 'Enter Task Name',
                  ),
                  maxLines: 3,
                ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          try {
            uploadToDb();
          } catch (e) {
            print(e);
          }
        },
        tooltip: "Add Task",
        child: const Icon(Icons.add),
      ),
    );
  }
}
