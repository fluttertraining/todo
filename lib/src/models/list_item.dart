import 'package:flutter/material.dart';
import './todo.dart';

class MyListItem {
  Color color;
  Color accentColor;
  String text;
  List<Todo> todos;

  MyListItem({
    @required this.color,
    @required this.accentColor,
    @required this.text,
    this.todos,
  });
}
