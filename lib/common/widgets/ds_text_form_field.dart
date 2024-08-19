import 'package:flutter/material.dart';

class DSTextFormField extends StatelessWidget {
  final String title;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool isPassword;
  final String? errorText;
  final Function(String)? onChanged;

  DSTextFormField({
    required this.title,
    this.validator,
    this.onChanged,
    this.keyboardType,
    this.isPassword = false,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty) ...[
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
        ],
        if (title.isEmpty)
          const SizedBox(
            height: 4,
          ),
        TextFormField(
          validator: validator,
          keyboardType: keyboardType,
          obscureText: isPassword,
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            errorText: errorText,
          ),
        )
      ],
    );
  }
}
