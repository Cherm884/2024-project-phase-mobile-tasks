import 'package:flutter/material.dart';
import 'package:e_commerce_app/detail_data.dart';

class DetaildPage extends StatefulWidget {
  const DetaildPage({super.key});

  @override
  State<DetaildPage> createState() => _DetaildPageState();
}

class _DetaildPageState extends State<DetaildPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductDetailPage(
        imagePath: 'assets/images/stock.jpg',
        category: 'Men’s shoes',
        rating: 4.0,
        productName: 'Trainer',
        price: '\$150',
        description:
            'These trainers feature a vibrant blue design with a breathable mesh upper, offering excellent ventilation and comfort. The shoes have a cushioned sole for enhanced support and a sleek, modern look with contrasting dark accents, making them ideal for both athletic performance and casual wear.',
      ),
    );
  }
}
