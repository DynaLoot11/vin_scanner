import 'package:flutter/material.dart';

class VinTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;

  VinTextField({
    Key? key,
    required this.controller,
    required this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.characters,
      maxLength: 17,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
        counterText: '',
      ),
    );
  }
}
