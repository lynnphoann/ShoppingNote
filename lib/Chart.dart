import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'ChatList.dart';
import 'Models/transaction.dart';

class Chart extends StatelessWidget {
  // const Chart({ Key? key }) : super(key: key);
  final List<Transaction> recentTransaction;
  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      int totalSum = 0;
      for (int i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].datetime.day == weekDay.day &&
            recentTransaction[i].datetime.month == weekDay.month &&
            recentTransaction[i].datetime.year == weekDay.year) {
          totalSum += recentTransaction[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(
        0, (sum, item) => sum + (item['amount'] as num));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      elevation: 6,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartList(
                  data['day'] as String,
                  data['amount'] as int,
                  data['amount'] as int == 0.0
                      ? 0.0
                      : (data['amount'] as int) / totalSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
