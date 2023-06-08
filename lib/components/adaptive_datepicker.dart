import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdaptativeDatePicker extends StatelessWidget {
  final DateTime? selectedDate;
  final Function(DateTime) onDateChange;

  const AdaptativeDatePicker({
    Key? key,
    this.selectedDate,
    required this.onDateChange,
  }) : super(key: key);

  _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      onDateChange(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Visibility(
          visible: Platform.isIOS,
          child: SizedBox(
            height: 180,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              minimumDate: DateTime(DateTime.now().year),
              maximumDate: DateTime.now(),
              onDateTimeChanged: onDateChange,
            ),
          ),
        ),
        Visibility(
          visible: !Platform.isIOS,
          child: SizedBox(
            height: 70,
            child: Row(
              children: [
                Text(
                  selectedDate == null
                      ? "Nenhuma data selecionada!"
                      : "Data selecionada: ${DateFormat("dd/MM/y").format(selectedDate!)}",
                ),
                const SizedBox(
                  width: 10,
                ),
                TextButton(
                  onPressed: () => _showDatePicker(context),
                  child: const Text(
                    "Selecionar data",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
