import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  TransactionForm({Key? key}) : super(key: key);

  final TextEditingController titleController = TextEditingController();
  final TextEditingController valueController = TextEditingController();

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
    );
  }
}
