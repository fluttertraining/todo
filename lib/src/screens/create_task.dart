import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CreateTaskScreen extends StatefulWidget {
  final Color backgroundColor;

  CreateTaskScreen({@required this.backgroundColor});

  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              color: Colors.white,
              height: 60,
              padding: EdgeInsets.symmetric(horizontal: 45),
              child: CupertinoTextField(
                placeholder: 'Vegas baby, Vegas!',
                textAlign: TextAlign.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
