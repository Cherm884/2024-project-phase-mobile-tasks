import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailPage extends StatelessWidget {
  final String imagePath;
  final String category;
  final double rating;
  final String productName;
  final String price;
  final String description;

  const ProductDetailPage({
    super.key,
    required this.imagePath,
    required this.category,
    required this.rating,
    required this.productName,
    required this.price,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 266,
                    width: double.infinity,
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      height: 266,
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.all(24),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.chevron_left),
                      color: Color.fromRGBO(63, 81, 243, 1),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(28, 22, 0, 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          category,
                          style: GoogleFonts.poppins(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color.fromRGBO(170, 170, 170, 1),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 32),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Color.fromRGBO(255, 215, 0, 1),
                              ),
                              Text(
                                '($rating)',
                                style: GoogleFonts.sora(
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16,
                                  color: Color.fromRGBO(170, 170, 170, 1),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            productName,
                            style: GoogleFonts.poppins(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                              color: Color.fromRGBO(2, 62, 62, 1),
                            ),
                          ),
                          Text(
                            price,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              color: Color.fromRGBO(62, 62, 62, 1),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 5),
                      SizedBox(
                        height: 60,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            _cardClass(39),
                            _cardClass(40),
                            _cardClass(
                              41,
                              color: Color.fromRGBO(68, 81, 243, 1),
                            ),
                            _cardClass(42),
                            _cardClass(43),
                            _cardClass(44),
                          ],
                        ),
                      ),
                    Container(
                      margin: EdgeInsets.only(top: 20, right: 32),
                      child: Text(
                        description,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(102, 102, 102, 1),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.red),
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 40,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: Text(
                              'DELETE',
                              style: GoogleFonts.poppins(
                                color: Color.fromRGBO(255, 19, 19, 0.79),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(63, 81, 243, 1),
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 40,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: Text(
                              'UPDATE',
                              style: GoogleFonts.poppins(
                                color: Color.fromRGBO(255, 255, 255, 0.79),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


Widget _cardClass(int size, {Color? color = Colors.white}) {
  return Container(
    color: Colors.white,
    // margin: EdgeInsets.only(right: 10),
    // padding: EdgeInsets.symmetric(horizontal: 16),
    // decoration: BoxDecoration(
    width: 60,
    height: 60,
    //   borderRadius: BorderRadius.circular(8),
    // ),
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
