import 'dart:io';
import 'productClass.dart';
import 'productManagerClass.dart';
import 'validateInputData.dart';

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
    stdout.write('Select an option (1-6): ');

    final choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        stdout.write('Enter product name: ');
        final name = stdin.readLineSync() ?? '';
        stdout.write('Enter product description: ');
        final description = stdin.readLineSync() ?? '';
        final price = readValidDouble('Enter product price: ');
        manager.addProduct(name, description, price);
        
        break;

      case '2':
        manager.viewAllProducts();
        break;

      case '3':
        final id = readValidInteger('Enter product ID: ');
        manager.viewProduct(id);
        break;

      case '4':
        final id = readValidInteger('Enter product ID to edit: ');
        bool hasKey3 = manager.products.keys.contains(id.toString());

        if (hasKey3 != true) {
          print('Product with ID $id not found.');
          
          break;
        }

        stdout.write('Enter new product name: ');
        final name = stdin.readLineSync() ?? '';
        stdout.write('Enter new product description: ');
        final description = stdin.readLineSync() ?? '';
        final price = readValidDouble('Enter New product price: ');
        manager.editProduct(id, name, description, price);

        break;

      case '5':
        final id = readValidInteger('Enter product ID to delete: ');
        manager.deleteProduct(id);
        break;

      case '6':
        print('Exiting application...');
        exit(0);

      default:
        print('Invalid option. Please try again.');
    }
  }
}
