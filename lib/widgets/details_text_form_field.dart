import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

InputDecoration inputDecoration({required String hint, String? suffixText}) {
  return InputDecoration(
    hintText: hint,
    suffixText: suffixText,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    filled: true,
    fillColor: Colors.grey.shade100,
    counterText: "",
  );
}

class DetailsTextFormField extends StatelessWidget {
  const DetailsTextFormField({super.key, required this.controller, required this.keyBoardType, required this.hint, this.suffixText="",  this.maxLength= 3});
final TextEditingController controller;
final TextInputType keyBoardType;
final String hint;
final String? suffixText;
final int maxLength ;




  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyBoardType,
      decoration: inputDecoration(hint: hint,suffixText: suffixText),
      maxLength: maxLength,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(maxLength),
      ],

    );
  }
}
