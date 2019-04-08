import 'dart:math' as math;
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

import './src/config/theme.dart';

import './src/models/list_item.dart';
import './src/models/todo.dart';

import './src/widgets/task_list_card.dart';

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
  static Duration _duration = Duration(minutes: 1);
  Timer _timer;
  double _percentage = 0;
  int _start = _duration.inSeconds;

  final List<MyListItem> listItems = [
    MyListItem(
      color: Colors.white,
      accentColor: deepBlue,
      text: "Daily Tasks",
      todos: [
        Todo(taskName: 'Wake up', date: DateTime.now()),
        Todo(taskName: 'Eat Breakfast', date: DateTime.now()),
      ],
    ),
    MyListItem(
      color: deepBlue,
      accentColor: Colors.white,
      text: "Tuesday Tasks",
      todos: [
        Todo(taskName: '1st block', date: DateTime.now()),
        Todo(taskName: '2nd block', date: DateTime.now()),
      ],
    ),
  ];

  String timerString() {
    var h = (_start / 3600).floor().toString();

    // Add trailing zeros if numbers reach 1 digit.
    var m = (_start % 3600 / 60).floor() % 10 > 10
        ? (_start % 3600 / 60).floor().toString()
        : (_start % 3600 / 60).floor().toString().padLeft(2, '0');

    var s = (_start % 3600 % 60) % 10 > 10
        ? (_start % 3600 % 60).floor().toString()
        : (_start % 3600 % 60).floor().toString().padLeft(2, '0');

    return "$h:$m:$s";
  }

  void startTimer() {
    if (_timer != null && _timer.isActive) {
      _timer.cancel();
      return;
    }

    const oneSecond = const Duration(seconds: 1);

    _timer = Timer.periodic(
      oneSecond,
      (Timer timer) => setState(() {
            if (_start < 1) {
              timer.cancel();
            } else {
              _start = _start - 1;
              _percentage = .99 - (_start / _duration.inSeconds);
            }
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.15;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: new _Salutation(fullName: 'Sean Urgel'),
            ),
            Expanded(
              child: GestureDetector(
                onTap: this.startTimer,
                child: CustomPaint(
                  painter: ClockPainter(
                    percentage: _percentage,
                    timeRemaining: timerString(),
                  ),
                  child: Container(),
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: _buildTaskActionWithTitle(context),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.only(left: 30),
                  margin: EdgeInsets.only(bottom: 30),
                  height: MediaQuery.of(context).size.height * .3,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: this.listItems.length,
                    itemBuilder: (BuildContext context, ndx) {
                      final MyListItem listItem = this.listItems[ndx];

                      return TaskListCard(
                        color: listItem.color,
                        title: listItem.text,
                        accentColor: listItem.accentColor,
                        todos: listItem.todos ?? [],
                        tag: 'TaskList$ndx',
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskActionWithTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
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
    );
  }
}

class _Salutation extends StatelessWidget {
  static final d = DateTime.now();

  final String fullName;

  _Salutation({Key key, this.fullName}) : super(key: key);

  String generateGreeting() {
    if (d.hour >= 18) {
      return 'Good Evening,';
    }

    if (d.hour >= 11) {
      return 'Good Afternoon,';
    }

    return 'Good Morning,';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          this.generateGreeting(),
          style: Theme.of(context).primaryTextTheme.headline,
        ),
        SizedBox(height: 3.5),
        Text(
          this.fullName,
          style: Theme.of(context).primaryTextTheme.subtitle,
        )
      ],
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
    ..color = const Color.fromRGBO(222, 234, 246, 1)
    ..strokeWidth = 4;

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
        canvas.drawLine(
          Offset(x + 187.5, y + 146),
          Offset(size.width / 2, size.height / 2),
          inactiveLinePaint,
        );
      } else {
        canvas.drawLine(
          Offset(x + 187.5, y + 146),
          Offset(size.width / 2, size.height / 2),
          activeLinePaint,
        );
      }
    }

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      radius - 12.5,
      circlePaint,
    );

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
    tp.paint(canvas, Offset((size.width / 2) - 40, (size.height / 2) - 12));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
