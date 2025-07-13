// ProductManager class to handle product operations
import 'productClass.dart';

class ProductManager {
  final Map<String, Product> products = {};

  int _idCounter = 1;

  // Add a new product
  void addProduct(String name, String description, double price) {
    products.addAll({
      _idCounter.toString(): Product(_idCounter++, name, description, price),
    });
    print('Product added successfully!');
  }

  // View all products
  void viewAllProducts() {
    if (products.isEmpty) {
      print('No products available.');
      return;
    }

    print('\nAll Products:');
    for (var entry in products.entries) {
      print('-------------------');
      print(entry.value);
    }
  }

  // View a single product by ID
  void viewProduct(int id) {
    
    bool hasId = products.keys.contains(id.toString());
    if (hasId != true) {
      print('Product with ID $id not found.');

    } 
    else {
      print('\nProduct Details:');
      print(products[id.toString()]);
    }
  }

  // Edit a product
  void editProduct(int id, String name, String description, double price) {

    try {
      bool hasKey = products.keys.contains(id.toString());

      if (hasKey == true) {
        products[id.toString()] = Product(id, name, description, price);
        print('Product updated successfully!');
        }
      } 
      catch (e) {
      print('Error editing product: $e');
    }
  }

  // Delete a product
  void deleteProduct(int id) {

    try {
      bool hasKey2 = products.keys.contains(id.toString());

      if (hasKey2 != true) {
        print('Product with ID $id not found.');
        return;

      } else {
        products.remove(id.toString());
        print('Product deleted successfully!');
      }

    } catch (e) {
      print('Error deleting product: $e');
    }
  }
}
