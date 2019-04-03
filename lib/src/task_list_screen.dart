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
        tag: tag,
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(50)),
            color: color,
            boxShadow: [
              BoxShadow(
                color: const Color.fromRGBO(225, 232, 238, 1),
                offset: Offset(12, 12),
              ),
            ],
          ),
          child: Container(
            padding: EdgeInsets.only(left: 30.0, top: 40.0, right: 10.0),
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
