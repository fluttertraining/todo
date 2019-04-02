import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  painter: ClockPainter(),
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
                      Container(
                        width: 200.0,
                        margin: EdgeInsets.only(right: 20, bottom: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromRGBO(225, 232, 238, 1),
                                offset: Offset(12, 12),
                              ),
                            ]),
                      ),
                      Container(
                        width: 200.0,
                        margin: EdgeInsets.only(right: 20, bottom: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromRGBO(225, 232, 238, 1),
                                offset: Offset(12, 12),
                              ),
                            ]),
                      ),
                      Container(
                        width: 200.0,
                        margin: EdgeInsets.only(right: 20, bottom: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromRGBO(225, 232, 238, 1),
                                offset: Offset(12, 12),
                              ),
                            ]),
                      ),
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
  var radius = 85;

  var linePaint = Paint()
    ..color = const Color.fromRGBO(71, 153, 247, 1)
    ..strokeWidth = 4;

  double degreesToRadians(degrees) {
    return degrees * math.pi / 180;
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (var ctr = 0; ctr < bars; ctr++) {
      var x = radius * math.cos(this.degreesToRadians(ctr * 6));
      var y = radius * math.sin(this.degreesToRadians(ctr * 6));

      canvas.drawLine(Offset(x, y), Offset.zero, linePaint);
    }

    canvas.drawCircle(Offset.zero, 75, Paint());
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
