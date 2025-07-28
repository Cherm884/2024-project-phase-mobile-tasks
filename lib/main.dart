import 'package:flutter/material.dart';
import 'package:e_commerce_app/screen/add_update.dart';
import 'package:e_commerce_app/screen/detailed_page.dart';
import 'package:e_commerce_app/screen/home.dart';
import 'package:e_commerce_app/screen/search_product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      routes: {
        '/add': (context) => AddUpdate(),
        '/search': (context) => SearchProduct(),
        '/detail': (context) => DetaildPage(),
      },
    );
  }
}
