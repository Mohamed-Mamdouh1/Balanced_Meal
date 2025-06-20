import 'package:flutter/material.dart';

class ActiveButton extends StatelessWidget {
  const ActiveButton({super.key, required this.buttonText, this.onPressed});
  final String buttonText;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(MediaQuery.of(context).size.width * 0.8, 60),
        backgroundColor: Colors.orange,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: onPressed,
      child: Text(buttonText, style: const TextStyle(color: Colors.white)),
    );
  }
}
