import 'dart:math';

import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionUser extends StatefulWidget {
  const TransactionUser({Key? key}) : super(key: key);

  @override
  State<TransactionUser> createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
  final List<Transaction> transactions = [
    Transaction(
        id: 't1',
        title: 'Novo Tênis de Corrida',
        value: 310.76,
        date: DateTime.now()),
    Transaction(
        id: 't2', title: 'Conta de luz', value: 211.30, date: DateTime.now()),
    Transaction(
        id: 't3', title: 'Conta #01', value: 211.30, date: DateTime.now()),
    Transaction(
        id: 't4', title: 'Conta #02', value: 211.30, date: DateTime.now()),
    Transaction(
        id: 't5', title: 'Conta #03', value: 211.30, date: DateTime.now()),
    Transaction(
        id: 't6', title: 'Conta #04', value: 211.30, date: DateTime.now()),
    Transaction(
        id: 't7', title: 'Conta #05', value: 211.30, date: DateTime.now()),
    Transaction(
        id: 't8', title: 'Conta #06', value: 211.30, date: DateTime.now()),
    Transaction(
        id: 't9', title: 'Conta #07', value: 211.30, date: DateTime.now()),
    Transaction(
        id: 't10', title: 'Conta #08', value: 211.30, date: DateTime.now()),
    Transaction(
        id: 't11', title: 'Conta #09', value: 211.30, date: DateTime.now()),
    Transaction(
        id: 't12', title: 'Conta #10', value: 211.30, date: DateTime.now()),
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

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TransactionForm(addTransaction: addTransaction),
      TransactionList(transactions: transactions)
    ]);
  }
}
