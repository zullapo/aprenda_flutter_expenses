import 'package:expenses/components/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key, required this.recentTransactions}) : super(key: key);

  final List<Transaction> recentTransactions;

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      DateTime weekDay = DateTime.now().add(Duration(days: index));
      String dayLetter = DateFormat.E('pt-BR').format(weekDay)[0].toUpperCase();
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

  double get weekTotalValue {
    return groupedTransactions.fold(0.0,
        (double previousValue, Map<String, Object> element) {
      return previousValue + (element['value'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactions
                .map(
                  (Map<String, Object> t) => Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                      label: t['day'] as String,
                      value: t['value'] as double,
                      percentage: weekTotalValue > 0
                          ? ((t['value'] as double) / weekTotalValue)
                          : 0,
                    ),
                  ),
                )
                .toList()),
      ),
    );
  }
}
