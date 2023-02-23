import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:second_prj/Chart.dart';
import 'Models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransaction;
  final Function deleteItem;
  final List<Transaction> recentTransaction;
  TransactionList(
      this.userTransaction, this.deleteItem, this.recentTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: userTransaction.isEmpty
            ? Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 100),
                      width: 400,
                      height: 250,
                      child: Image.asset(
                        'assest/images/emptyBasket1.gif',
                        fit: BoxFit.cover,
                      )),
                  // SizedBox(),
                  Text(
                    'Empty!',
                    style: TextStyle(
                        color: Colors.black38,
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  )
                ],
              )
            : Column(
                children: [
                  Chart(recentTransaction),
                  Container(
                    height: 600,
                    child: ListView.builder(
                        itemCount: userTransaction.length,
                        itemBuilder: (ctx, index) {
                          return Card(
                            margin: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 5),
                            elevation: 5,
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 30,
                                child: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: FittedBox(
                                      child: Text(
                                          '${userTransaction[index].amount} K')),
                                ),
                              ),
                              title: Text(
                                userTransaction[index].title,
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(DateFormat.yMMMd()
                                  .format(userTransaction[index].datetime)),
                              trailing: IconButton(
                                onPressed: () =>
                                    deleteItem(userTransaction[index].id),
                                icon: Icon(
                                  Icons.delete,
                                  color: Theme.of(context).errorColor,
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ));
  }
}
