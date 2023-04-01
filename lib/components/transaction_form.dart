import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  TransactionForm({Key? key, required this.addTransaction}) : super(key: key);

  final TextEditingController titleController = TextEditingController();
  final TextEditingController valueController = TextEditingController();
  final void Function(String title, double value) addTransaction;

  void submitForm() {
    String title = titleController.text;
    double value = double.tryParse(valueController.text) ?? 0;
    if (title.isEmpty || value <= 0) {
      return;
    }
    addTransaction(title, value);
  }

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
              keyboardType: TextInputType.number,
              onFieldSubmitted: (_) {
                submitForm();
              },
              decoration: const InputDecoration(labelText: "Valor (R\$)")),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: submitForm,
                  child: const Text("Nova transação",
                      style: TextStyle(color: Colors.purple)))
            ],
          )
        ]),
      ),
    );
  }
}
