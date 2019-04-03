import 'dart:math' as math;
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

import './src/list_item.dart';
import './src/route_animations.dart';
import './src/task_list_screen.dart';
import './src/theme.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Symph Monitor 3.0',
      theme: themeData,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Duration duration;
  double percentage = 0;
  Timer _timer;
  int start;

  final List<MyListItem> listItems = [
    MyListItem(Colors.white, "Daily Tasks"),
    MyListItem(deepBlue, "Tuesday Tasks"),
  ];

  initState() {
    super.initState();

    duration = Duration(minutes: 1);
    start = duration.inSeconds;
    // startTimer();
  }

  String timerString() {
    var h = (start / 3600).floor().toString();

    // Add trailing zeros if numbers reach 1 digit.
    var m = (start % 3600 / 60).floor() % 10 > 10
        ? (start % 3600 / 60).floor().toString()
        : (start % 3600 / 60).floor().toString().padLeft(2, '0');

    var s = (start % 3600 % 60) % 10 > 10
        ? (start % 3600 % 60).floor().toString()
        : (start % 3600 % 60).floor().toString().padLeft(2, '0');

    return "$h:$m:$s";
  }

  void startTimer() {
    const oneSecond = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSecond,
      (Timer timer) => setState(() {
            if (start < 1) {
              timer.cancel();
            } else {
              start = start - 1;
              percentage = .99 - (start / duration.inSeconds);
            }
          }),
    );
  }

  Widget _buildTaskActionWithTitle(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
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
    );
  }

  Widget _buildSalutation(BuildContext context) {
    return Column(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.1;

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
              child: _buildSalutation(context),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .2,
              child: Center(
                child: GestureDetector(
                  onTap: this.startTimer,
                  child: CustomPaint(
                    painter: ClockPainter(
                        percentage: percentage, timeRemaining: timerString()),
                  ),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                _buildTaskActionWithTitle(context),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.only(left: 30),
                  margin: EdgeInsets.only(
                    bottom: 30,
                  ),
                  height: MediaQuery.of(context).size.height * .3,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: listItems.length,
                    itemBuilder: (BuildContext context, ndx) => _TaskListCard(
                          context: context,
                          color: listItems[ndx].color,
                          title: listItems[ndx].text,
                          tag: 'TaskList$ndx',
                        ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TaskListCard extends StatelessWidget {
  const _TaskListCard({
    Key key,
    @required this.context,
    @required this.color,
    @required this.title,
    @required this.tag,
  }) : super(key: key);

  final BuildContext context;
  final Color color;
  final String title;
  final String tag;

  void navigateToToScreen(TextStyle titleStyle) {
    Navigator.of(context).push(
      FadeInSlideOutRoute(
        builder: (BuildContext context) => TaskListScreen(
              title: title,
              textStyle: titleStyle,
              color: color,
              tag: tag,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var titleStyle;
    var listItemStyle;

    if (color == Theme.of(context).primaryColor) {
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
      onTap: () => navigateToToScreen(titleStyle),
      child: Hero(
        tag: tag,
        child: Container(
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
          child: Padding(
            padding: EdgeInsets.only(top: 35.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(title, style: titleStyle),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
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
                        style: listItemStyle,
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
  }
}

class ClockPainter extends CustomPainter {
  var bars = 60;
  var radius = 100.0;

  final double percentage;
  final String timeRemaining;

  ClockPainter({@required this.percentage, @required this.timeRemaining});

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

      if (ctr / bars >= percentage) {
        canvas.drawLine(Offset(x, y), Offset.zero, activeLinePaint);
      } else {
        canvas.drawLine(Offset(x, y), Offset.zero, inactiveLinePaint);
      }
    }

    canvas.drawCircle(Offset.zero, radius - 15, circlePaint);

    var splitTime = timeRemaining.split('.');

    var span = new TextSpan(
      style: new TextStyle(
        color: deepBlue,
        fontWeight: FontWeight.w700,
        fontSize: 24,
      ),
      text: splitTime[0],
    );

    var tp = new TextPainter(
      text: span,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );

    tp.layout();
    tp.paint(canvas, Offset(-40, -12));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
