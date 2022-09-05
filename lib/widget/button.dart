import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String buttonText;
  void Function()? onPressed;
  MyButton({Key? key, required this.buttonText, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(buttonText),
        ),
      ),
    ));
  }
}
