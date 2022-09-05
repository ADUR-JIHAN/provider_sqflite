import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String label;
  void Function(String?)? onSaved;
  String? Function(String?)? validator;
  MyTextField({Key? key, required this.label, this.onSaved, this.validator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: TextFormField(
        onSaved: onSaved,
        validator: validator,
        decoration: InputDecoration(
            labelText: label,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
