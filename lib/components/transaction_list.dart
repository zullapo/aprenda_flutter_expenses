import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({Key? key, required this.transactions})
      : super(key: key);

  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 223,
        child: transactions.isEmpty
            ? Column(children: [
                const SizedBox(height: 20),
                Text("Nenhuma transação cadastrada",
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 20),
                SizedBox(
                    height: 158,
                    child: Image.asset("assets/images/waiting.png",
                        fit: BoxFit.cover)),
              ])
            : ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  Transaction t = transactions[index];
                  return Card(
                      child: Row(children: [
                    Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2,
                        )),
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "R\$${t.value?.toStringAsFixed(2)}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Theme.of(context).colorScheme.primary),
                        )),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            t.title!,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(DateFormat('d MMM y').format(t.date!),
                              style: const TextStyle(color: Colors.grey))
                        ])
                  ]));
                },
              ));
  }
}
