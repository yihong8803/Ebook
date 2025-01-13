import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTabs extends StatefulWidget {
  final Color color;
  final String text;
  const AppTabs({super.key, required this.color, required this.text});

  @override
  State<AppTabs> createState() => _AppTabsState();
}

class _AppTabsState extends State<AppTabs> {
  //Color Changed after Click
  List<Color> myColors = [Colors.green, Colors.red, Colors.yellow, Colors.blue];
  late Color currentColor;
  int index = 0;

  var random = Random();

  void changeColorIndex() {
    setState(() {
      index = random.nextInt(myColors.length);
      currentColor = myColors[index];
    });
  }

  @override
  void initState() {
    super.initState();
    // Initialize currentColor with the widget's default color
    currentColor = widget.color;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 50,
      child: Text(
        this.widget.text,
        style: TextStyle(color: Colors.white, fontSize: 15),
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: currentColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 7,
              offset: Offset(0, 0),
            ),
          ]),
    );
  }
}
