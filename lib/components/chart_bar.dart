import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar(
      {Key? key,
      required this.label,
      required this.value,
      required this.percentage})
      : super(key: key);

  final String label;
  final double value;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text("R\$${value.toStringAsFixed(2)}"),
      const SizedBox(height: 5),
      const SizedBox(height: 60, width: 10, child: null),
      const SizedBox(height: 5),
      Text(label)
    ]);
  }
}
