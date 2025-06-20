import 'package:flutter/material.dart';

class DisabledButton extends StatelessWidget {
  const DisabledButton({super.key, required this.buttonText});
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width:  MediaQuery.of(context).size.width * 0.8,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade300,
        ),
        child: Center(
          child: Text(
              buttonText,
              style: const TextStyle(color: Colors.grey),
          textAlign: TextAlign.center,),
        ),
      ),
    );
  }
}
