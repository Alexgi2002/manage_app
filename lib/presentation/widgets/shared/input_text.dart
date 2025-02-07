import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  const InputText({super.key, 
    required this.textController,
    required this.label, 
    required this.keyboardType, 
    this.minLines = 1,
    this.maxLines = 5,
    this.maxLength, 
    this.textInputAction,
    this.prefixIcon,
  });

  final TextEditingController textController;
  final TextInputAction? textInputAction;
  final String label;
  final TextInputType keyboardType;
  final int minLines;
  final int maxLines;
  final int? maxLength;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: textController,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        minLines: minLines,
        maxLines: maxLines,
        maxLength: maxLength,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: prefixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}