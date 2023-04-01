import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  TransactionForm({Key? key, required this.addTransaction}) : super(key: key);

  final TextEditingController titleController = TextEditingController();
  final TextEditingController valueController = TextEditingController();
  final void Function(String title, double value) addTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          TextFormField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Título")),
          TextFormField(
              controller: valueController,
              decoration: const InputDecoration(labelText: "Valor (R\$)")),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    addTransaction(titleController.text,
                        double.tryParse(valueController.text) ?? 0);
                  },
                  child: const Text("Nova transação",
                      style: TextStyle(color: Colors.purple)))
            ],
          )
        ]),
      ),
    );
  }
}
