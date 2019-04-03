import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  final Color color;
  final TextStyle textStyle;
  final String taskName;
  final bool isFinished;
  final Function onPressTask;

  TaskItem({
    Key key,
    @required this.color,
    @required this.textStyle,
    @required this.taskName,
    @required this.isFinished,
    @required this.onPressTask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Material(
          elevation: 0,
          color: color,
          child: Checkbox(
            value: this.isFinished,
            onChanged: onPressTask,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
        Text(
          this.taskName,
          style: textStyle,
          overflow: TextOverflow.fade,
          softWrap: true,
        ),
      ],
    );
  }
}
