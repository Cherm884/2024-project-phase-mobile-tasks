import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/add_update.dart';
import 'package:flutter_application_1/product_card.dart';
import 'package:flutter_application_1/screen/search_product.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Square leading icon
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color.fromRGBO(204, 204, 204, 1),
                      ),
                    ),
                    SizedBox(width: 13),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'July 14, 2023',
                          style: GoogleFonts.syne(
                            fontStyle: FontStyle.normal,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(170, 170, 170, 1),
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Hello, ',
                                style: GoogleFonts.sora(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(102, 102, 102, 1),
                                ),
                              ),
                              TextSpan(
                                text: 'Yohannes',
                                style: GoogleFonts.sora(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // Column with Hello and name

                // Notification icon
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromRGBO(221, 221, 221, 1)),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Icon(
                    Icons.notifications_none,
                    color: Color.fromRGBO(102, 102, 102, 1),
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Available Products',
                  style: GoogleFonts.poppins(
                    fontStyle: FontStyle.normal,
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromRGBO(217, 217, 217, 1),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchProduct()),
                    ),
                    icon: Icon(
                      Icons.search,
                      color: Color.fromRGBO(217, 217, 217, 1),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 22),
            ProductCard(
              imagePath: 'assets/images/stock.jpg',
              productName: 'Trainers Shoes',
              price: '\$150',
              category: 'Men’s shoe',
              rating: 4.0,
            ),
            ProductCard(
              imagePath: 'assets/images/shoes.jpg',
              productName: 'Derby Leather Shoes',
              price: '\$120',
              category: 'Men’s shoe',
              rating: 4.0,
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: 72,
        width: 72,
        child: FloatingActionButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddUpdate()),
          ),
          backgroundColor: Color.fromRGBO(63, 81, 243, 1),
          shape: const CircleBorder(),
          child: Icon(Icons.add, color: Colors.white, size: 32),
        ),
      ),
    );
  }
}
