import 'dart:io';
import 'package:flutter/services.dart';

Future<String> fixture(String name) async {
  // First try synchronous file read (for unit tests)
  try {
    return File('test/fixtures/$name').readAsStringSync();
  } catch (e) {
    // Fall back to async bundle load (for widget tests)
    try {
      return await rootBundle.loadString('test/fixtures/$name');
    } catch (e) {
      throw Exception('Failed to load fixture: $name. Error: $e');
    }
  }
}