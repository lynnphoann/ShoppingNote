import 'package:flutter/material.dart';
import '/Chart.dart';
import 'new_transaction.dart';
import 'transactionList.dart';
import 'Models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Quicksand',
        primarySwatch: Colors.purple,
        accentColor: Colors.black,
        appBarTheme: AppBarTheme(
            color: Colors.black,
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                  ),
                )),
      ),
      title: 'Shopping Note',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];

  List<Transaction> get _recentTransaction {
    return _userTransactions.where((element) {
      return element.datetime
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTx(String title, int amount, DateTime datePick) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        datetime: datePick);

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _StartAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTx);
        });
  }

  void _deleteItem(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Note'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _StartAddNewTransaction(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child:
            TransactionList(_userTransactions, _deleteItem, _recentTransaction),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _StartAddNewTransaction(context),
        child: Icon(
          Icons.add,
        ),
        // backgroundColor: Colors.purple,
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
