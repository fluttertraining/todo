import 'package:flutter/material.dart';

import './task.dart';
import './todo.dart';

class TaskListScreen extends StatefulWidget {
  final String title;
  final Color color;
  final Color accentColor;
  final String tag;
  final List<Todo> todos;

  TaskListScreen({
    Key key,
    @required this.title,
    @required this.color,
    @required this.tag,
    @required this.accentColor,
    @required this.todos,
  }) : super(key: key);

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final double appBarHeight = 100.0;

  onPressTask(int ndx) => (bool value) {
        setState(() {
          widget.todos[ndx].isFinished = value;
        });
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, double.maxFinite),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 100),
          height: appBarHeight,
          child: AppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
            actions: [
              CircleAvatar(
                child: Text('S'),
              ),
              Padding(padding: EdgeInsets.only(right: 16))
            ],
          ),
        ),
      ),
      body: Hero(
        tag: widget.tag,
        child: Task(
          title: widget.title,
          color: widget.color,
          accentColor: widget.accentColor,
          todos: widget.todos,
          onPressTask: this.onPressTask,
          isSelected: true,
        ),
      ),
    );
  }
}
