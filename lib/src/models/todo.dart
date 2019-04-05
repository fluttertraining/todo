import 'package:flutter/material.dart';

class Todo {
  bool isFinished;
  String taskName;
  DateTime date;

  Todo({
    this.isFinished = false,
    @required this.taskName,
    this.date,
  });
}
