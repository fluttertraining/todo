import 'package:flutter/material.dart';
import './route_animations.dart';
import './task_item.dart';
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

  onPressTask(int ndx) => (bool value) {
        setState(() {
          widget.todos[ndx].isFinished = value;
        });
      };

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
        child: Container(
          width: 220.0,
          margin: EdgeInsets.only(right: 22.5, bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: widget.color,
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
                      Text(widget.title, style: titleStyle),
                      Material(
                        elevation: 0,
                        color: widget.color,
                        child: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {},
                          iconSize: 26,
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
                      itemCount: widget.todos.length,
                      padding: EdgeInsets.only(top: 0),
                      itemBuilder: (BuildContext context, ndx) => TaskItem(
                            color: widget.color,
                            textStyle: listItemStyle,
                            taskName: widget.todos[ndx].taskName,
                            isFinished: widget.todos[ndx].isFinished,
                            onPressTask: onPressTask(ndx),
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
