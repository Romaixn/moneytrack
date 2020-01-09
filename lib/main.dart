import 'package:flutter/material.dart';

import 'package:moneytrack/pages/base_page.dart';

void main() => runApp(MoneyTrack());

class MoneyTrack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.black,
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )
          )
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold
          )
        )
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => BasePage(),
      },
      debugShowCheckedModeBanner: true,
    );
  }
}