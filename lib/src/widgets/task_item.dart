import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  final Color color, accentColor;
  final TextStyle textStyle;
  final String taskName, taskTime;
  final bool isFinished, isSelected;
  final Function onPressTask;

  TaskItem({
    Key key,
    @required this.color,
    @required this.textStyle,
    @required this.taskName,
    @required this.isFinished,
    @required this.onPressTask,
    @required this.accentColor,
    this.taskTime,
    this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool notNull(Object o) => o != null;

    return Row(children: <Widget>[
      Material(
        elevation: 0,
        color: color,
        child: Checkbox(
          value: this.isFinished,
          onChanged: onPressTask,
          activeColor: accentColor,
          checkColor: color,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
      Flexible(
        child: Row(
          children: <Widget>[
            Flexible(
              child: Text(
                this.isSelected ? "$taskName at" : taskName,
                style: !isFinished
                    ? textStyle
                    : textStyle.copyWith(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey[300],
                      ),
                overflow: TextOverflow.fade,
                softWrap: true,
              ),
            ),
            this.isSelected
                ? Flexible(
                    child: Text(
                      " $taskTime",
                      style: !isFinished
                          ? textStyle.copyWith(color: accentColor)
                          : textStyle.copyWith(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey[300],
                            ),
                    ),
                  )
                : null
          ].where(notNull).toList(),
        ),
      ),
    ]);
  }
}
