import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  final String text;
  final Color color;
  final double size;

  const SmallText({
    super.key,

    this.size = 12,
    this.color = const Color(0xFF332d2b),
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontFamily: 'Roboto',
      ),
    );
  }
}
