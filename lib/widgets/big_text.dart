import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  final TextOverflow overflow;

  const BigText({
    super.key,
    this.overflow = TextOverflow.ellipsis,
    this.size = 20,
    this.color = const Color(0xFF332d2b),
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
