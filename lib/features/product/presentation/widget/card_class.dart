import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardClass extends StatelessWidget {
  final int size;
  final Color color;

  const CardClass({
    super.key,
    required this.size,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 60,
      height: 60,
      child: Card(
        color: color,
        child: Center(
          child: Text(
            size.toString(),
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: color == Colors.white ? Colors.black : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
