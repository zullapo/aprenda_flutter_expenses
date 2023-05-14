import 'dart:math';

import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

import 'components/chart.dart';

void main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MaterialApp(
      home: const MyHomePage(),
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: Colors.purple,
          secondary: Colors.amber,
        ),
        textTheme: theme.textTheme.copyWith(
          titleLarge: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          labelLarge: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
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
      id: 't0',
      title: 'Conta Antiga',
      value: 400.00,
      date: DateTime.now().subtract(
        const Duration(days: 33),
      ),
    ),
    Transaction(
      id: 't1',
      title: 'Novo Tênis de Corrida',
      value: 310.76,
      date: DateTime.now().subtract(
        const Duration(days: 3),
      ),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de Luz',
      value: 211.30,
      date: DateTime.now().subtract(
        const Duration(days: 4),
      ),
    ),
  ];

  bool _showChart = false;

  List<Transaction> get recentTransactions {
    return transactions
        .where(
          (Transaction t) => t.date!.isAfter(
            DateTime.now().subtract(
              const Duration(days: 7),
            ),
          ),
        )
        .toList();
  }

  addTransaction(String title, double value, DateTime date) {
    Transaction transaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );
    transactions.add(transaction);
    setState(() {});
    Navigator.pop(context);
  }

  removeTransaction(String id) {
    setState(() {
      transactions.removeWhere((Transaction t) => t.id == id);
    });
  }

  showTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(addTransaction: addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      title: const Text("Despesas Pessoais"),
      actions: [
        IconButton(
          onPressed: () {
            showTransactionFormModal(context);
          },
          icon: const Icon(Icons.add),
        ),
        if (isLandscape)
          IconButton(
            onPressed: () {
              setState(() {
                _showChart = !_showChart;
              });
            },
            icon: Icon(_showChart ? Icons.list : Icons.show_chart),
          ),
      ],
    );

    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_showChart || !isLandscape)
              SizedBox(
                height: availableHeight * (isLandscape ? 0.8 : 0.3),
                child: Chart(
                  recentTransactions: recentTransactions,
                ),
              ),
            if (!_showChart || !isLandscape)
              SizedBox(
                height: availableHeight * (isLandscape ? 1 : 0.7),
                child: TransactionList(
                  transactions: transactions,
                  removeTransaction: removeTransaction,
                ),
              )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showTransactionFormModal(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
