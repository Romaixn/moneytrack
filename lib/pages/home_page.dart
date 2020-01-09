import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.only(top: 20.0),
      child: Text(
        'Home page',
        style: Theme.of(context).textTheme.title,
      )
    );
  }
}