import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'models/transaction.dart';

void main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  final TextEditingController titleController = TextEditingController();
  final TextEditingController valueController = TextEditingController();

  final List<Transaction> _transactions = [
    Transaction(
        id: 't1',
        title: 'Novo Tênis de Corrida',
        value: 310.76,
        date: DateTime.now()),
    Transaction(
        id: 't2', title: 'Conta de Luz', value: 211.30, date: DateTime.now())
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Despesas Pessoais")),
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const SizedBox(
              child: Card(
                  elevation: 5, color: Colors.blue, child: Text("Gráfico"))),
          Column(
              children: _transactions
                  .map((Transaction t) => Card(
                          child: Row(children: [
                        Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            decoration: BoxDecoration(
                                border: Border.all(
                              color: Colors.purple,
                              width: 2,
                            )),
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "R\$${t.value?.toStringAsFixed(2)}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.purple),
                            )),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                t.title!,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(DateFormat('d MMM y').format(t.date!),
                                  style: const TextStyle(color: Colors.grey))
                            ])
                      ])))
                  .toList()),
          Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(children: [
                TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(labelText: "Título")),
                TextFormField(
                    controller: valueController,
                    decoration:
                        const InputDecoration(labelText: "Valor (R\$)")),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          print(titleController.text);
                          print(valueController.text);
                        },
                        child: const Text("Nova transação",
                            style: TextStyle(color: Colors.purple)))
                  ],
                )
              ]),
            ),
          )
        ]));
  }
}
