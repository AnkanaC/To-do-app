import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class dashBoardPage extends StatefulWidget {
  const dashBoardPage({super.key});

  @override
  State<dashBoardPage> createState() => _dashBoardPageState();
}

class _dashBoardPageState extends State<dashBoardPage> {
  Future<void> uploadToDb() async {
    try {
      final data =
          await FirebaseFirestore.instance.collection("Daily Tasks").add({
        "Task Name": "Jogging",
        "Date": "12-12-2022",
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasks"),
      ),
      body: const Center(
        child: Column(
          children: [],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          try {
            uploadToDb();
          } catch (e) {
            print(e);
          }
          ;
        },
        tooltip: "Add Task",
        child: const Icon(Icons.add),
      ),
    );
  }
}
