import 'package:flutter/foundation.dart';

class Transaction {
  final int id;
  final double amount;
  final String description;
  final String date;

  Transaction({this.id, @required this.amount, @required this.description, this.date});

  factory Transaction.fromMap(Map<String, dynamic> json) => new Transaction(
    id: json['id'],
    amount: json['amount'],
    description: json['description'],
    date: json['date']
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "amount": amount,
    "description": description,
    "date": date,
  };
}