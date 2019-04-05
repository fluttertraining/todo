import 'package:flutter/material.dart';
import './route_animations.dart';
import './task.dart';
import '../config/theme.dart';
import '../models/todo.dart';
import '../screens/task_list.dart';

class TaskListCard extends StatefulWidget {
  final BuildContext context;
  final Color color;
  final String title;
  final String tag;
  final Color accentColor;
  final List<Todo> todos;

  const TaskListCard({
    Key key,
    @required this.context,
    @required this.color,
    @required this.title,
    @required this.tag,
    @required this.accentColor,
    @required this.todos,
  }) : super(key: key);

  @override
  _TaskListCardState createState() => _TaskListCardState();
}

class _TaskListCardState extends State<TaskListCard> {
  void navigateToListScreen() {
    Navigator.of(widget.context).push(
      FadeInSlideOutRoute(
        builder: (BuildContext context) => TaskListScreen(
              title: widget.title,
              color: widget.color,
              tag: widget.tag,
              todos: widget.todos,
              accentColor:
                  widget.color == Colors.white ? deepBlue : Colors.white,
            ),
      ),
    );
  }

  void onPressTask(int ndx) => (bool value) => setState(() {
        widget.todos[ndx].isFinished = value;
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.navigateToListScreen,
      child: Hero(
        tag: widget.tag,
        child: new Task(
          title: widget.title,
          color: widget.color,
          todos: widget.todos,
          accentColor: widget.color == Colors.white ? deepBlue : Colors.white,
          onPressTask: onPressTask,
        ),
      ),
    );
  }
}
