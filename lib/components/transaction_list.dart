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
      height: 270,
      child: transactions.isEmpty
          ? Column(children: [
              const SizedBox(height: 20),
              Text(
                "Nenhuma transação cadastrada",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              SizedBox(
                  height: 200,
                  child: Image.asset(
                    "assets/images/waiting.png",
                    fit: BoxFit.cover,
                  )),
            ])
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                Transaction t = transactions[index];
                return Card(
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text("R\$ ${t.value!.toStringAsFixed(0)}"),
                        ),
                      ),
                    ),
                    title: Text(
                      t.title!,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Text(
                      DateFormat("d MMM y").format(t.date!),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
