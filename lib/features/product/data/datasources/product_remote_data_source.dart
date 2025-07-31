import 'dart:convert';
import 'dart:core';

import 'package:dartz/dartz.dart';

import 'package:http/http.dart' as http;
import '../../../../core/error/exceptions.dart';
import '../../domain/entites/product.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  /// Throws a [ServerException] for all error codes.
  Future<List<Product>> getAllProducts();

  /// Throws a [ServerException] for all error codes.
  Future<Product> getProductById(String id);

  /// Throws a [ServerException] for all error codes.
  Future<Unit> createProduct(Product product);

  /// Throws a [ServerException] for all error codes.
  Future<Unit> updateProduct(Product product);

  /// Throws a [ServerException] for all error codes.
  Future<Unit> deleteProduct(String id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;
  String baseUrl =
      'https://g5-flutter-learning-path-be.onrender.com/api/v1/products';

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<Unit> createProduct(Product product) async {
    final response = await client.get(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return unit;
    } else {
      throw ServerException(
        'Failed to create product (${response.statusCode})',
      );
    }
  }

  @override
  Future<Unit> deleteProduct(String id) async {
    final response = await client.delete(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      return unit;
    } else {
      throw ServerException(
        'Failed to delete product (${response.statusCode})',
      );
    }
  }

  @override
  Future<List<Product>> getAllProducts() async {
    final response = await client.get(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body);
      return decodedJson
          .map<ProductModel>((jsonItem) => ProductModel.fromJson(jsonItem))
          .toList();
    } else {
      throw ServerException('Failed to load products (${response.statusCode})');
    }
  }

  @override
  Future<Product> getProductById(String id) async {
    final response = await client.get(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson = json.decode(response.body);
      return ProductModel.fromJson(decodedJson);
    } else {
      throw ServerException('Failed to load product (${response.statusCode})');
    }
  }

  @override
  Future<Unit> updateProduct(Product product) async {
    final response = await client.get(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return unit;
    } else {
      throw ServerException(
        'Failed to create product (${response.statusCode})',
      );
    }
  }
}
