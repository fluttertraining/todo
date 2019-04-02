import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import './theme.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // FlutterStatusbarcolor.setStatusBarWhiteForeground(false);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: themeData,
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final percentage = 0.44;

  @override
  void initState() {
    super.initState();
  }

  Widget _buildTaskListCard(Color color, String title) {
    var textStyle = color == Theme.of(context).primaryColor
        ? Theme.of(context).primaryTextTheme.title.copyWith(color: Colors.white)
        : Theme.of(context).primaryTextTheme.title;

    return Container(
      width: 220.0,
      margin: EdgeInsets.only(right: 22.5, bottom: 10),
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
      child: Container(
        padding: EdgeInsets.only(left: 12.0, top: 35.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: textStyle),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.menu),
              color: Theme.of(context).accentColor,
              onPressed: () {},
            ),
            CircleAvatar(
              child: Text('S'),
            )
          ],
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Good Afternoon,',
                    style: Theme.of(context).primaryTextTheme.headline,
                  ),
                  SizedBox(height: 3.5),
                  Text(
                    'Sean Urgel',
                    style: Theme.of(context).primaryTextTheme.subtitle,
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .2,
              child: Center(
                child: CustomPaint(
                  painter: ClockPainter(percentage: percentage),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Tasks List',
                        style: Theme.of(context).primaryTextTheme.title,
                      ),
                      IconButton(
                        icon: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Colors.red[400],
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Icon(
                            Icons.add,
                            color: Theme.of(context).backgroundColor,
                          ),
                        ),
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.only(left: 30),
                  margin: EdgeInsets.only(
                    bottom: 30,
                  ),
                  height: MediaQuery.of(context).size.height * .3,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      _buildTaskListCard(Colors.white, 'Daily Tasks'),
                      _buildTaskListCard(
                          Theme.of(context).primaryColor, 'Another Task'),
                      _buildTaskListCard(Colors.white, 'And another task'),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  var bars = 60;
  var radius = 90;
  final double percentage;

  ClockPainter({@required this.percentage});

  var activeLinePaint = Paint()
    ..color = const Color.fromRGBO(71, 153, 247, 1)
    ..strokeWidth = 4;

  var inactiveLinePaint = Paint()
    ..color = Color.fromRGBO(222, 234, 246, 1)
    ..strokeWidth = 4;

  var circleShadowPaint = Paint()..color = Colors.grey;
  var circlePaint = Paint()..color = Colors.white;

  double degreesToRadians(degrees) {
    return degrees * math.pi / 180;
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (var ctr = 0; ctr < bars; ctr++) {
      var rad = this.degreesToRadians((ctr * 6) - 90);
      var x = radius * math.cos(rad);
      var y = radius * math.sin(rad);

      if (ctr / bars > percentage) {
        canvas.drawLine(Offset(x, y), Offset.zero, inactiveLinePaint);
      } else {
        canvas.drawLine(Offset(x, y), Offset.zero, activeLinePaint);
      }
    }

    // canvas.drawCircle(Offset(1, 2.5), 75, circleShadowPaint);
    canvas.drawCircle(Offset.zero, 75, circlePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
