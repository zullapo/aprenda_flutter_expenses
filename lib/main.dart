import 'dart:math';

import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

void main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transactions = [
    Transaction(
        id: 't1',
        title: 'Novo Tênis de Corrida',
        value: 310.76,
        date: DateTime.now()),
    Transaction(
        id: 't2', title: 'Conta de luz', value: 211.30, date: DateTime.now()),
    Transaction(id: 't3', title: 'Teste', value: 211.30, date: DateTime.now()),
  ];

  addTransaction(String title, double value) {
    Transaction transaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: DateTime.now());
    transactions.add(transaction);
    setState(() {});
  }

  showTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(addTransaction: addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Despesas Pessoais"), actions: [
          IconButton(
              onPressed: () {
                showTransactionFormModal(context);
              },
              icon: const Icon(Icons.add))
        ]),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            const SizedBox(
                child: Card(
                    elevation: 5, color: Colors.blue, child: Text("Gráfico"))),
            TransactionList(transactions: transactions)
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showTransactionFormModal(context);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
