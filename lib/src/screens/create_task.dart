import 'package:flutter/material.dart';

class CreateTaskScreen extends StatefulWidget {
  final Color backgroundColor;

  CreateTaskScreen({@required this.backgroundColor});

  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: widget.backgroundColor,
      ),
    );
  }
}
