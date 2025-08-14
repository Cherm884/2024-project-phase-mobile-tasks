import 'package:flutter/material.dart';
import 'features/product/presentation/page/create_product_page.dart';
import 'features/product/presentation/page/product_list_page.dart';
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ProductsListPage(),routes: {'/productList': (context) => const ProductsListPage(),
    
    '/createProduct': (context) => const CreateProductPage()},
    );
  }
}
