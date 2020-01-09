import 'package:flutter/material.dart';

import 'package:moneytrack/models/database.dart';
import 'package:moneytrack/widgets/transaction_list.dart';

class MoneyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: TransactionList(TransactionDatabaseProvider.db.getAllTransaction()),
    );
  }
}