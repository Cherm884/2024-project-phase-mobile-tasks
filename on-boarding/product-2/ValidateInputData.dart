import 'dart:io';

// validate the input value is double
double readValidDouble(String message) {
  while (true) {
    
    stdout.write(message);
    final input = stdin.readLineSync();
    final value = double.tryParse(input ?? '');
    
    if (value != null && value > 0) return value;
    print('Invalid price! Enter a valid number greater than 0.');
  }
}

// validate the inpute value is integer
int readValidInteger(String message) {
  while (true) {
    
    stdout.write(message);
    final input = stdin.readLineSync();
    final value = int.tryParse(input ?? '');

    if (value != null && value >= 1) {
      return value;
      
    } 
    else {
      print('Invalid input! Please enter an integer value greater than 0.');
    }
  }
}
