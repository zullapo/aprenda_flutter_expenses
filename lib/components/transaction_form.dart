import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({Key? key, required this.addTransaction})
      : super(key: key);

  final void Function(String title, double value, DateTime date) addTransaction;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController valueController = TextEditingController();
  DateTime? selectedDate;

  void submitForm() {
    String title = titleController.text;
    double value = double.tryParse(valueController.text) ?? 0;
    if (title.isEmpty || value <= 0) {
      return;
    }
    widget.addTransaction(
        title, value, selectedDate != null ? selectedDate! : DateTime.now());
  }

  showDatePickerModal() {
    DateTime now = DateTime.now();
    showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year),
      lastDate: now,
    ).then((value) => setState(() => selectedDate = value));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
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
                Text(selectedDate == null
                    ? "Nenhuma data selecionada!"
                    : "Data selecionada: ${DateFormat("dd/MM/y").format(selectedDate!)}"),
                const SizedBox(
                  width: 10,
                ),
                TextButton(
                  onPressed: showDatePickerModal,
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
      ),
    );
  }
}
