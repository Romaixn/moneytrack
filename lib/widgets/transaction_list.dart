import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneytrack/models/database.dart';

import 'package:moneytrack/models/transaction.dart';
import 'package:moneytrack/pages/edit_or_add_transaction.dart';

class TransactionList extends StatelessWidget {
  final Future<List<Transaction>> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Transaction>>(
      future: transactions,
      builder: (BuildContext context, AsyncSnapshot<List<Transaction>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            shrinkWrap: false,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              Transaction item = snapshot.data[index];
              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  color: Theme.of(context).errorColor,
                  child: Text("Remove", style: Theme.of(context).textTheme.title),
                ),
                onDismissed: (direction) {
                  TransactionDatabaseProvider.db.deleteTransactionWithId(item.id);
                },
                child:  Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(child: Text('\$${item.amount}')),
                      ),
                    ),
                    title: Text(
                      item.description,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(DateTime.parse(item.date)),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditOrCreateTransaction(
                          true,
                          transaction: item,
                        )
                      ));
                    },
                  )
                ),
              );
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      }
    );
  }
}