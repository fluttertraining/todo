import 'package:flutter/material.dart';

import './task_item.dart';
import './todo.dart';

class Task extends StatelessWidget {
  final Color color;
  final String title;
  final Color accentColor;
  final List<Todo> todos;
  final Function onPressTask;
  final bool isSelected;

  Task({
    Key key,
    @required this.onPressTask,
    @required this.color,
    @required this.title,
    @required this.accentColor,
    @required this.todos,
    this.isSelected = false,
  }) : super(key: key);

  String getTaskTime(int ndx) {
    final amOrPm = (this.todos[ndx].date.hour < 12) ? 'AM' : 'PM';

    final hour = (this.todos[ndx].date.hour % 12).toString();
    final minutes = this.todos[ndx].date.minute;

    print(this.todos[ndx].date.hour % 12);

    var formattedMinutes = minutes >= 10
        ? this.todos[ndx].date.minute.toString()
        : "0" + this.todos[ndx].date.minute.toString();

    return "$hour:$formattedMinutes $amOrPm";
  }

  @override
  Widget build(BuildContext context) {
    var titleStyle;
    var listItemStyle;

    if (this.color == Theme.of(context).primaryColor) {
      titleStyle =
          Theme.of(context).textTheme.title.copyWith(color: Colors.white);
      listItemStyle = Theme.of(context).primaryTextTheme.subtitle.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.normal,
            letterSpacing: 0.4,
          );
    } else {
      titleStyle = Theme.of(context).textTheme.title;
      listItemStyle = Theme.of(context).primaryTextTheme.subtitle.copyWith(
            color: Theme.of(context).accentColor,
            fontWeight: FontWeight.normal,
            letterSpacing: 0.4,
          );
    }

    return Container(
      width: this.isSelected ? MediaQuery.of(context).size.width : 220.0,
      margin: this.isSelected
          ? EdgeInsets.only(top: 20)
          : EdgeInsets.only(right: 22.5, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: this.isSelected
            ? BorderRadius.only(topRight: Radius.circular(50))
            : BorderRadius.circular(16),
        color: this.color,
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(225, 232, 238, 1),
            offset: Offset(12, 12),
          ),
        ],
      ),
      child: Padding(
        padding: this.isSelected
            ? EdgeInsets.only(top: 40.0, right: 10.0)
            : EdgeInsets.only(top: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: this.isSelected
                  ? EdgeInsets.only(left: 30.0)
                  : EdgeInsets.only(left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(this.title, style: titleStyle),
                  Material(
                    elevation: 0,
                    color: this.color,
                    child: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {},
                      iconSize: this.isSelected ? 36 : 26,
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
                        textStyle: listItemStyle,
                        taskName: this.todos[ndx].taskName,
                        isFinished: this.todos[ndx].isFinished,
                        onPressTask: this.onPressTask(ndx),
                        accentColor: this.accentColor,
                        isSelected: this.isSelected,
                        taskTime: getTaskTime(ndx),
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
