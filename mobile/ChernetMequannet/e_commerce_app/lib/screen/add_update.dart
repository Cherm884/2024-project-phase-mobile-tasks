import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AddUpdate extends StatefulWidget {
  const AddUpdate({super.key});

  @override
  State<AddUpdate> createState() => _AddUpdateState();
}

class _AddUpdateState extends State<AddUpdate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Add Product',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: const Color.fromRGBO(62, 62, 62, 1),
          ),
        ),

        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Color.fromRGBO(63, 81, 243, 1),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Upload Image Section
              Container(
                height: 190,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(243, 243, 243, 1),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image, size: 50),
                      const SizedBox(height: 8),
                      Text(
                        'upload image',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromRGBO(62, 62, 62, 1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 22.0),
              // Name Field
              TextPart(label: 'name'),
              const SizedBox(height: 8.0),
              // Category Field
              TextPart(label: 'category'),
              const SizedBox(height: 8.0),
              // Price Field
              TextPart(label: 'price', suffixText: '\$'),
              const SizedBox(height: 8.0),
              // Description Field
              TextPart(label: 'description', maxLines: 5),
              const SizedBox(height: 24.0),
              // ADD Button
              ElevatedButton(
                onPressed: () {
                  // Add your add logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(63, 81, 243, 1),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  'ADD',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Color.fromRGBO(255, 255, 255, 0.79),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              // DELETE Button
              OutlinedButton(
                onPressed: () {
                  // Add your delete logic here
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: Text(
                  'DELETE',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Color.fromRGBO(255, 19, 19, 0.79),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextPart extends StatelessWidget {
  final String label;

  final String? suffixText;
  final int? maxLines;

  const TextPart({
    super.key,
    required this.label,
    this.suffixText,
    this.maxLines,
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
        const SizedBox(height: 8.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: TextField(
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
