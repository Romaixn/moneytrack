import 'package:flutter/material.dart';
import 'package:moneytrack/models/database.dart';
import 'package:moneytrack/models/transaction.dart';

class EditOrCreateTransaction extends StatefulWidget {
  final bool edit;
  final Transaction transaction;

  EditOrCreateTransaction(this.edit, {this.transaction}) : assert(edit == true || transaction == null);

  @override
  _EditOrCreateTransactionState createState() => _EditOrCreateTransactionState();
}

class _EditOrCreateTransactionState extends State<EditOrCreateTransaction> {
  TextEditingController descriptionEditingController = TextEditingController();
  TextEditingController amountEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  static DateTime now = new DateTime.now();
  DateTime date = new DateTime(now.year, now.month, now.day);

  @override
  void initState() {
    super.initState();
    if(widget.edit == true) {
      descriptionEditingController.text = widget.transaction.description;
      amountEditingController.text = widget.transaction.amount.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.edit?"Edit Transaction":"Add Transaction")),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                textFormField(descriptionEditingController, "Description", "Enter description", Icons.description, widget.edit ? widget.transaction.description : "s"),
                textFormField(amountEditingController, "Amount", "Enter amount", Icons.attach_money, widget.edit ? widget.transaction.amount.toString() : "jk"),
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(!_formKey.currentState.validate()) {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Processing data'),
                        )
                      );
                    } else if(widget.edit == true) {
                      TransactionDatabaseProvider.db.updateTransaction(
                        new Transaction(
                          description: descriptionEditingController.text,
                          amount: double.parse(amountEditingController.text),
                          id: widget.transaction.id,
                          date: date.toString()
                        )
                      );
                      Navigator.pop(context);
                    } else {
                      await TransactionDatabaseProvider.db.addTransaction(
                        new Transaction(
                          description: descriptionEditingController.text,
                          amount: double.parse(amountEditingController.text),
                          date: date.toString()
                        )
                      );
                      Navigator.pop(context);
                    }
                  },
                )
              ],
            )
          )
        )
      )
    );
  }

  textFormField(TextEditingController t, String label, String hint,
      IconData iconData, String initialValue) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter some text';
          } else {
            return '';
          }
        },
        controller: t,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
            prefixIcon: Icon(iconData),
            hintText: hint,
            labelText: label,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}