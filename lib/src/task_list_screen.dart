import 'package:flutter/material.dart';

import './task_item.dart';
import './todo.dart';

class TaskListScreen extends StatefulWidget {
  final String title;
  final TextStyle textStyle;
  final Color color;
  final Color accentColor;
  final String tag;
  final List<Todo> todos;

  TaskListScreen({
    Key key,
    @required this.title,
    @required this.textStyle,
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
    final amOrPm = (widget.todos[ndx].date.hour % 12 == 0) ? 'AM' : 'PM';
    final hour = (widget.todos[ndx].date.hour % 12).toString();
    final minutes = widget.todos[ndx].date.minute.toString();

    return this.widget.todos[ndx].taskName + " at $hour:$minutes $amOrPm";
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
        actions: <Widget>[
          CircleAvatar(
            child: Text('S'),
          ),
          Padding(padding: EdgeInsets.only(right: 16))
        ],
      ),
      body: Hero(
        tag: widget.tag,
        child: Container(
          margin: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(50)),
            color: widget.color,
            boxShadow: [
              BoxShadow(
                color: const Color.fromRGBO(225, 232, 238, 1),
                offset: Offset(12, 12),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 40.0, right: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(widget.title, style: widget.textStyle),
                      Material(
                        elevation: 0,
                        color: widget.color,
                        child: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {},
                          iconSize: 36,
                          color: widget.accentColor,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: ListView.builder(
                      itemCount: this.widget.todos.length,
                      padding: EdgeInsets.only(top: 0),
                      itemBuilder: (BuildContext context, ndx) => TaskItem(
                            color: widget.color,
                            textStyle: widget.textStyle,
                            taskName: getTaskNameWithDate(ndx),
                            isFinished: this.widget.todos[ndx].isFinished,
                            onPressTask: this.onPressTask(ndx),
                          ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
