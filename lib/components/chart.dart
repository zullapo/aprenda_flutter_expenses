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
      double transactionValue = recentTransactions
          .map((Transaction value) => value.value)
          .toList()
          .reduce((double? value, double? element) => value! + element!)!;
      return {"day": dayLetter, "value": transactionValue};
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Row(children: []),
    );
  }
}
