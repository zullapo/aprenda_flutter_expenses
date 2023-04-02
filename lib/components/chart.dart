import 'package:expenses/components/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key, required this.recentTransactions}) : super(key: key);

  final List<Transaction> recentTransactions;

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      DateTime weekDay = DateTime.now().subtract(Duration(days: index));
      String dayLetter = DateFormat.E().format(weekDay)[0];
      double sumTransactionValue = 0;
      for (Transaction recentTransaction in recentTransactions) {
        bool sameDay = recentTransaction.date?.day == weekDay.day;
        bool sameMonth = recentTransaction.date?.month == weekDay.month;
        bool sameYear = recentTransaction.date?.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          sumTransactionValue += recentTransaction.value!;
        }
      }
      return {"day": dayLetter, "value": sumTransactionValue};
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 6,
        margin: const EdgeInsets.all(20),
        child: Row(
            children: groupedTransactions
                .map((Map<String, Object> t) => ChartBar(
                    label: t['day'] as String,
                    value: t['value'] as double,
                    percentage: 0.3))
                .toList()),
      ),
    );
  }
}
