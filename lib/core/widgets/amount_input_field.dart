import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AmountInputField extends StatelessWidget {
  final TextEditingController controller;
  final String? prefix;
  final String? suffix;
  final String hintText;
  final double width;
  final ValueChanged<String>? onChanged;
  final bool isInteger;

  const AmountInputField({
    super.key,
    required this.controller,
    this.prefix,
    this.suffix,
    this.hintText = '0.00',
    this.width = 100,
    this.onChanged,
    this.isInteger = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (prefix != null)
            Text(
              prefix!,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: isInteger
                  ? TextInputType.number
                  : const TextInputType.numberWithOptions(decimal: true),
              inputFormatters:
                  isInteger ? [FilteringTextInputFormatter.digitsOnly] : null,
              textAlign: TextAlign.end,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: isInteger ? '0' : hintText,
                isDense: true,
                border: const UnderlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(vertical: 4),
              ),
              style: const TextStyle(fontSize: 14),
            ),
          ),
          if (suffix != null)
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                suffix!,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
