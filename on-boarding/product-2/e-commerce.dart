import "dart:io";

// Base Product class with inheritance support
class Product {
  String _name;
  String _description;
  double _price;

  Product(this._name, this._description, this._price);

  // Getters
  String get name => _name;
  String get description => _description;
  double get price => _price;

  // Setters
  set name(String value) {
    if (value.isEmpty) throw ProductException('Product name cannot be empty');
    _name = value;
  }

  set description(String value) => _description = value;
  set price(double value) {
    if (value < 0) throw ProductException('Price cannot be negative');
    _price = value;
  }

  @override
  String toString() {
    return '\nProduct_Name: $_name\nProduct_Description: $_description\nPrice: \$${_price.toStringAsFixed(2)}\n';
  }
}

// Custom exception for product-related errors
class ProductException implements Exception {
  final String message;
  ProductException(this.message);

  @override
  String toString() => 'ProductException: $message';
}

// ProductManager class to handle product operations
class ProductManager {
  final List<Product> _products = [];

  // Add a new product
  void addProduct(Product product) {
    try {
      
      if (_products.any(
        (p) => p.name.toLowerCase() == product.name.toLowerCase(),
      ))
        _products.add(product);
      print('Product "${product.name}" added successfully');
    } catch (e) {
      print('Error adding product: $e');
    }
  }

  // View all products
  void viewAllProducts() {
    try {
      if (_products.isEmpty) {
        throw ProductException('No products available');
      }
      print('\nAll Products:');
      for (var i = 0; i < _products.length; i++) {
        print('${i + 1}. ${_products[i]}');
      }
    } catch (e) {
      print('Error viewing products: $e');
    }
  }

  // View a single product by name
  Product? viewProduct(String name) {
    try {
      final product = _products.firstWhere(
        (p) => p.name.toLowerCase() == name.toLowerCase(),
        orElse: () => throw ProductException('Product "$name" not found'),
      );
      print('\nProduct Details:');
      print(product);
      return product;
    } catch (e) {
      print('Error viewing product: $e');
      return null;
    }
  }

  // Edit a product
  void editProduct(
    String name,
    String newName,
    String newDescription,
    double newPrice,
  ) {
    try {
      final product = viewProduct(name);
      if (product != null) {
        // Check if new name already exists (and isn't the current product)
        if (newName != name &&
            _products.any(
              (p) => p.name.toLowerCase() == newName.toLowerCase(),
            )) {
          throw ProductException('Product with name "$newName" already exists');
        }
        product.name = newName;
        product.description = newDescription;
        product.price = newPrice;
        print('Product "$name" updated successfully');
      }
    } catch (e) {
      print('Error editing product: $e');
    }
  }

  // Delete a product
  void deleteProduct(String name) {
    try {
      final product = viewProduct(name);
      if (product != null) {
        _products.removeWhere(
          (p) => p.name.toLowerCase() == name.toLowerCase(),
        );
        print('Product "$name" deleted successfully');
      }
    } catch (e) {
      print('Error deleting product: $e');
    }
  }
}

// Main function with menu-driven interface
void main() {
  final manager = ProductManager();

  while (true) {
    print('\n=== eCommerce Application ===');
    print('1. Add Product');
    print('2. View All Products');
    print('3. View Product');
    print('4. Edit Product');
    print('5. Delete Product');
    print('6. Exit');
    print('Enter your choice (1-6): ');

    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        try {
          print('Enter product name: ');
          String? name = stdin.readLineSync();
          print('Enter product description: ');
          String? description = stdin.readLineSync();
          print('Enter product price: ');
          String? priceStr = stdin.readLineSync();

          if (name == null || description == null || priceStr == null) {
            throw ProductException('Invalid input');
          }

          double price = double.parse(priceStr);
          // Example using inheritance
          Product product = Product(name, description, price);
          manager.addProduct(product);
        } catch (e) {
          print('Error: $e');
        }
        break;

      case '2':
        manager.viewAllProducts();
        break;

      case '3':
        print('Enter product name to view: ');
        String? name = stdin.readLineSync();
        if (name != null) {
          manager.viewProduct(name);
        } else {
          print('Error: Invalid input');
        }
        break;

      case '4':
        try {
          print('Enter product name to edit: ');
          String? name = stdin.readLineSync();
          print('Enter new product name: ');
          String? newName = stdin.readLineSync();
          print('Enter new product description: ');
          String? newDescription = stdin.readLineSync();
          print('Enter new product price: ');
          String? newPriceStr = stdin.readLineSync();

          if (name == null ||
              newName == null ||
              newDescription == null ||
              newPriceStr == null) {
            throw ProductException('Invalid input');
          }

          double newPrice = double.parse(newPriceStr);
          manager.editProduct(name, newName, newDescription, newPrice);
        } catch (e) {
          print('Error: $e');
        }
        break;

      case '5':
        print('Enter product name to delete: ');
        String? name = stdin.readLineSync();
        if (name != null) {
          manager.deleteProduct(name);
        } else {
          print('Error: Invalid input');
        }
        break;

      case '6':
        print('Thank you for using eCommerce Application!');
        return;

      default:
        print('Invalid choice. Please enter a number between 1 and 6.');
    }
  }
}
