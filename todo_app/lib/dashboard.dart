import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/task.dart';
import 'package:intl/intl.dart';

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
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection("Daily Tasks").get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No Data is found"));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var task = snapshot.data!.docs[index];

              String timeText;
              if (task.data().containsKey("Time") && task["Time"] != null) {
                try {
                  timeText = DateFormat.jm().format(DateTime.parse(task["Time"].toString()));
                } catch (e) {
                  timeText = "Invalid Time";
                }
              } else {
                timeText = "Time not available";
              }

              return Card(
                margin: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        task.data().containsKey("Task Name") ? task["Task Name"] : "No Task Name",
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        timeText,
                        style: const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
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
