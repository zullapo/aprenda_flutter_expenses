import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Function(String)? onFieldSubmitted;
  final TextInputType? keyboardType;

  const AdaptiveTextFormField({
    Key? key,
    required this.controller,
    required this.label,
    this.onFieldSubmitted,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Visibility(
          visible: Platform.isIOS,
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            child: CupertinoTextField(
              controller: controller,
              onSubmitted: onFieldSubmitted,
              keyboardType: keyboardType,
              placeholder: label,
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 12,
              ),
            ),
          ),
        ),
        Visibility(
          visible: !Platform.isIOS,
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(labelText: label),
            onFieldSubmitted: onFieldSubmitted,
            keyboardType: keyboardType,
          ),
        ),
      ],
    );
  }
}
