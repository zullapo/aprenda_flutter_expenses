import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({Key? key, required this.addTransaction})
      : super(key: key);

  final void Function(String title, double value) addTransaction;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController valueController = TextEditingController();

  void submitForm() {
    String title = titleController.text;
    double value = double.tryParse(valueController.text) ?? 0;
    if (title.isEmpty || value <= 0) {
      return;
    }
    widget.addTransaction(title, value);
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
            decoration: const InputDecoration(labelText: "Título"),
          ),
          TextFormField(
            controller: valueController,
            keyboardType: TextInputType.number,
            onFieldSubmitted: (_) {
              submitForm();
            },
            decoration: const InputDecoration(labelText: "Valor (R\$)"),
          ),
          Row(
            children: [
              const Text("Nenhuma data selecionada!"),
              const SizedBox(
                width: 10,
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Selecionar data",
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  textStyle: TextStyle(
                    color: Theme.of(context).textTheme.labelLarge!.color,
                    fontWeight:
                        Theme.of(context).textTheme.labelLarge!.fontWeight,
                  ),
                ),
                child: const Text(
                  "Nova transação",
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}
