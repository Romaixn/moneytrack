
import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:moneytrack/models/transaction.dart' as transaction_model;
import 'package:sqflite/sqflite.dart';

class TransactionDatabaseProvider {
  TransactionDatabaseProvider._();

  static final TransactionDatabaseProvider db = TransactionDatabaseProvider._();
  Database _database;

  Future<Database> get database async {
    if(_database != null) return _database;
    _database = await getDatabaseInstance();
    return _database;
  }

  Future<Database> getDatabaseInstance() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "moneytrack.db");
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE user_transaction(id INTEGER PRIMARY KEY, amount DOUBLE, description TEXT, date TEXT)"
        );
      }
    );
  }

  addTransaction(transaction_model.Transaction transaction) async {
    final db = await database;
    var raw = await db.insert(
      "user_transaction",
      transaction.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
    return raw;
  }

  updateTransaction(transaction_model.Transaction transaction) async {
    final db = await database;
    var response = await db.update(
      "user_transaction",
      transaction.toMap(),
      where: "id = ?", whereArgs: [transaction.id]
    );
    return response;
  }

  Future<transaction_model.Transaction> getTransactionWithId(int id) async {
    final db = await database;
    var response = await db.query(
      "user_transaction",
      where: 'id = ?', whereArgs: [id]
    );
    return response.isNotEmpty ? transaction_model.Transaction.fromMap(response.first) : null;
  }

  Future<List<transaction_model.Transaction>> getAllTransaction() async {
    final db = await database;
    var response = await db.query(
      "user_transaction",
      orderBy: "id DESC"
    );
    List<transaction_model.Transaction> list = response.map((c) => transaction_model.Transaction.fromMap(c)).toList();
    return list;
  }

  deleteTransactionWithId(int id) async {
    final db = await database;
    return db.delete(
      "user_transaction",
      where: "id = ?", whereArgs: [id]
    );
  }
}