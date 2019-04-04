import 'package:flutter/material.dart';

import './task_item.dart';
import './todo.dart';

class Task extends StatelessWidget {
  final Color color;
  final String title;
  final String tag;
  final Color accentColor;
  final List<Todo> todos;
  final TextStyle titleStyle;
  final TextStyle listItemStyle;
  final Function onPressTask;

  Task({
    Key key,
    @required this.onPressTask,
    @required this.titleStyle,
    @required this.listItemStyle,
    @required this.color,
    @required this.title,
    @required this.tag,
    @required this.accentColor,
    @required this.todos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220.0,
      margin: EdgeInsets.only(right: 22.5, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: this.color,
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(225, 232, 238, 1),
            offset: Offset(12, 12),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(this.title, style: titleStyle),
                  Material(
                    elevation: 0,
                    color: this.color,
                    child: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {},
                      iconSize: 26,
                      color: this.accentColor,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ListView.builder(
                  itemCount: this.todos.length,
                  padding: EdgeInsets.only(top: 0),
                  itemBuilder: (BuildContext context, ndx) => TaskItem(
                        color: this.color,
                        textStyle: this.listItemStyle,
                        taskName: this.todos[ndx].taskName,
                        isFinished: this.todos[ndx].isFinished,
                        onPressTask: this.onPressTask(ndx),
                        accentColor: this.accentColor,
                      ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
