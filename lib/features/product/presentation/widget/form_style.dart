import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class TextPart extends StatelessWidget {
  final String label;
  final String? suffixText;
  final int? maxLines;
  final TextEditingController control;

  const TextPart({
    super.key,
    required this.label,
    this.suffixText,
    this.maxLines,
    required this.control,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color.fromRGBO(62, 62, 62, 1),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(6),
          ),
          child: TextField(
            controller: control,
            maxLines: maxLines ?? 1,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              suffixText: suffixText,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
