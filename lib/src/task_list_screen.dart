import 'package:flutter/material.dart';

class TaskListScreen extends StatelessWidget {
  final String title;
  final TextStyle textStyle;
  final Color color;
  final String tag;

  TaskListScreen({
    Key key,
    @required this.title,
    @required this.textStyle,
    @required this.color,
    @required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 40),
        child: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        ),
      ),
      body: Container(
        width: 500.0,
        margin: EdgeInsets.only(right: 22.5, bottom: 10, top: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: color,
          boxShadow: [
            BoxShadow(
              color: const Color.fromRGBO(225, 232, 238, 1),
              offset: Offset(12, 12),
            ),
          ],
        ),
        child: Hero(
          tag: tag,
          child: Container(
            padding: EdgeInsets.only(left: 12.0, top: 35.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: textStyle),
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
