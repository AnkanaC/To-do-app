import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/dashboard.dart';
import 'package:todo_app/successPage.dart';

class taskPage extends StatefulWidget {
  const taskPage({super.key});

  @override
  State<taskPage> createState() => _taskPageState();
}

class _taskPageState extends State<taskPage> {
  final titleController = TextEditingController();
  String currentTime =
      DateFormat('EEEE, MMMM d, y HH:mm:ss').format(DateTime.now());
  final dateController = TextEditingController();
  final _timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _updateTime();
  }

  void _updateTime() {
    if (!mounted) return;
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          currentTime =
              DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
        });
        _updateTime();
      }
    });
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        final now = DateTime.now();
        final selectedTime = DateTime(
            now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);
        _timeController.text = DateFormat('hh:mm a').format(selectedTime);
      });
    }
  }

  Future<void> uploadToDb() async {
    try {
      final data =
          await FirebaseFirestore.instance.collection("Daily Tasks").add({
        "Task Name": titleController.text.trim(),
        "Date": DateTime.now(),
        "Time": _timeController.text.trim(),
      });
      print("Data Uploaded Successfully");
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
                  labelText: 'Task Name',
                  prefix: Icon(Icons.task),
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: TextField(
                controller: _timeController,
                decoration: const InputDecoration(
                  labelText: 'Select Time',
                  prefixIcon: Icon(Icons.access_time),
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
                onTap: () => _selectTime(context),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                try {
                  uploadToDb();
                } catch (e) {
                  print(e);
                }
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const Successpage()),
                );
              },
              child: const Text('Save Task',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
