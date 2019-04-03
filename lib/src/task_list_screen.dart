import 'package:flutter/material.dart';

class TaskListScreen extends StatelessWidget {
  final String title;
  final TextStyle textStyle;
  final Color color;
  final Color accentColor;
  final String tag;

  TaskListScreen({
    Key key,
    @required this.title,
    @required this.textStyle,
    @required this.color,
    @required this.tag,
    @required this.accentColor,
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
                      Text(title, style: textStyle),
                      Material(
                        elevation: 0,
                        color: color,
                        child: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {},
                          iconSize: 36,
                          color: accentColor,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: <Widget>[
                      Material(
                        elevation: 0,
                        color: color,
                        child: Checkbox(
                          value: true,
                          onChanged: (value) {},
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                      Text(
                        'Sup',
                        style: textStyle,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
