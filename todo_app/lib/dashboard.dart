import 'package:flutter/material.dart';
import 'package:todo_app/task.dart';

class dashBoardPage extends StatefulWidget {
  const dashBoardPage({super.key});

  @override
  State<dashBoardPage> createState() => _dashBoardPageState();
}

class _dashBoardPageState extends State<dashBoardPage> {

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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const taskPage(),
            ),
          );
        },
        tooltip: "Add Task",
        child: const Icon(Icons.add),
      ),
    );
  }
}
