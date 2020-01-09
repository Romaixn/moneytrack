import 'package:flutter/material.dart';

import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:moneytrack/pages/edit_or_add_transaction.dart';

import 'package:moneytrack/pages/home_page.dart';
import 'package:moneytrack/pages/money_page.dart';
import 'package:moneytrack/pages/stats_page.dart';
import 'package:moneytrack/pages/menu_page.dart';

class BasePage extends StatefulWidget {
  @override
  _BasePageScreenState createState() => _BasePageScreenState();
}

class _BasePageScreenState extends State<BasePage> {
  int _currentIndex;
  final List<Widget> _children = [
    HomePage(),
    MoneyPage(),
    StatsPage(),
    MenuPage(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
  }

  void changePage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Money Tracker')),
      body: _children[_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => EditOrCreateTransaction(false))
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BubbleBottomBar(
        hasNotch: true,
        fabLocation: BubbleBottomBarFabLocation.end,
        opacity: .2,
        currentIndex: _currentIndex,
        onTap: changePage,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16)
        ),
        elevation: 8,
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
            backgroundColor: Colors.red,
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.home,
              color: Colors.red,
            ),
            title: Text("Home")
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.deepPurple,
            icon: Icon(
              Icons.account_balance_wallet,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.account_balance_wallet,
              color: Colors.deepPurple,
            ),
            title: Text("Money")
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.indigo,
            icon: Icon(
              Icons.show_chart,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.show_chart,
              color: Colors.indigo,
            ),
            title: Text("Stats")
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.green,
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.menu,
              color: Colors.green,
            ),
            title: Text("Menu")
          ),
        ],
      ),
    );
  }
}