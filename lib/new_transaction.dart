import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTx;

  NewTransaction(this.addNewTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? datePicker;

  void _sumbitDum() {
    final enterTitle = titleController.text;
    final enterAmount = int.parse(amountController.text);
    if (enterTitle.isEmpty || enterAmount <= 0 || datePicker == null) {
      return;
    }

    widget.addNewTx(enterTitle, enterAmount, datePicker);
    Navigator.of(context).pop();
  }

  void _dateSelector() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      } else {
        setState(() {
          datePicker = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => _sumbitDum(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              onSubmitted: (_) => _sumbitDum(),
            ),
            Container(
              margin: EdgeInsets.only(top: 40),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      datePicker == null
                          ? 'No date choosen'
                          : 'Choosen Date : ${DateFormat.yMd().format(datePicker as DateTime)}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  TextButton(
                    onPressed: _dateSelector,
                    child: Text('Select Date'),
                    style: TextButton.styleFrom(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17)),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, right: 10),
              child: ElevatedButton(
                onPressed: _sumbitDum,
                child: Text(' Add '),
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(fontSize: 16),
                  // primary: Colors.purple[400],
                  padding: EdgeInsets.symmetric(horizontal: 15),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
