import 'package:flutter/material.dart';
import './route_animations.dart';
import './task.dart';
import './task_list_screen.dart';
import './theme.dart';
import './todo.dart';

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
  void navigateToListScreen(TextStyle titleStyle) {
    Navigator.of(widget.context).push(
      FadeInSlideOutRoute(
        builder: (BuildContext context) => TaskListScreen(
              title: widget.title,
              textStyle: titleStyle,
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
    var titleStyle;
    var listItemStyle;

    if (widget.color == Theme.of(context).primaryColor) {
      titleStyle =
          Theme.of(context).textTheme.title.copyWith(color: Colors.white);
      listItemStyle = Theme.of(context)
          .primaryTextTheme
          .subtitle
          .copyWith(color: Colors.white);
    } else {
      titleStyle = Theme.of(context).textTheme.title;
      listItemStyle = Theme.of(context)
          .primaryTextTheme
          .subtitle
          .copyWith(color: Theme.of(context).accentColor);
    }

    return GestureDetector(
      onTap: () => navigateToListScreen(titleStyle),
      child: Hero(
        tag: widget.tag,
        child: new Task(
          titleStyle: titleStyle,
          listItemStyle: listItemStyle,
          title: widget.title,
          color: widget.color,
          tag: widget.tag,
          todos: widget.todos,
          accentColor: widget.color == Colors.white ? deepBlue : Colors.white,
          onPressTask: onPressTask,
        ),
      ),
    );
  }
}
