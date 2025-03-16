import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_app/dashboard.dart';

class Successpage extends StatefulWidget {
  const Successpage({super.key});

  @override
  State<Successpage> createState() => _SuccesspageState();
}

class _SuccesspageState extends State<Successpage> {

  @override 
  void initState() { 
    super.initState(); 
    Timer(const Duration(seconds: 1), 
      ()=>Navigator.pushReplacement(context, 
          MaterialPageRoute(builder: (context) =>  const dashBoardPage() 
        ), 
      ),
    ); 
  } 

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 100,
              ),
              Text("Task Added Successfully"),
            ],
          ),
        ),
      ),
    );
  }
}