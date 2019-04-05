import 'package:flutter/material.dart';

import '../models/todo.dart';
import '../widgets/task.dart';

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
  bool isAdding = false;
  double appBarHeight = 120.0;

  onPressTask(int ndx) => (bool value) {
        setState(() {
          widget.todos[ndx].isFinished = value;
        });
      };

  void onPressAdd() {
    setState(() {
      isAdding = !isAdding;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, double.maxFinite),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 150),
          height: isAdding ? 80 : appBarHeight,
          child: GestureDetector(
            onTap: isAdding ? this.onPressAdd : null,
            child: AnimatedOpacity(
              opacity: isAdding ? 0 : 1,
              duration: Duration(milliseconds: 150),
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
          onPressAdd: this.onPressAdd,
        ),
      ),
    );
  }
}
