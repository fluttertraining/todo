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
  String getTaskNameWithDate(int ndx) {
    final amOrPm = (widget.todos[ndx].date.hour < 12) ? 'AM' : 'PM';

    final hour = (widget.todos[ndx].date.hour % 12).toString();
    final minutes = widget.todos[ndx].date.minute;

    print(widget.todos[ndx].date.hour % 12);

    var formattedMinutes = minutes >= 10
        ? widget.todos[ndx].date.minute.toString()
        : "0" + widget.todos[ndx].date.minute.toString();

    return this.widget.todos[ndx].taskName +
        " at $hour:$formattedMinutes $amOrPm";
  }

  onPressTask(int ndx) => (bool value) {
        setState(() {
          widget.todos[ndx].isFinished = value;
        });
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
