import 'dart:convert';
import 'dart:core';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entites/product.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<Product>> getAllProducts();
  Future<Product> getProductById(String id);

  Future<Unit> createProduct(Product product, String imagePath);
  Future<Unit> updateProduct(Product product, String id);
  Future<Unit> deleteProduct(String id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;
  String baseUrl =
      'https://g5-flutter-learning-path-be-tvum.onrender.com/api/v1/products';

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<Unit> createProduct(Product product, String imagePath) async {
    var request = http.MultipartRequest('POST', Uri.parse(baseUrl))
      ..fields['name'] = product.name
      ..fields['description'] = product.description
      ..fields['price'] = product.price.toString()
      ..files.add(
        await http.MultipartFile.fromPath(
          'image',
          imagePath,
          contentType: MediaType('image', 'jpeg'),
        ),
      );

    var response = await request.send();

    if (response.statusCode == 201) {
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
    final uri = Uri.parse(baseUrl);
    final response = await client.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded =
          json.decode(response.body) as Map<String, dynamic>;

      // The server returns a top-level object with a `data` array.
      final data = decoded['data'];
      if (data is List) {
        return data
            .map<ProductModel>(
              (jsonItem) =>
                  ProductModel.fromJson(jsonItem as Map<String, dynamic>),
            )
            .toList();
      } else {
        // No data array — return empty list (or throw if you prefer)
        return <Product>[];
      }
    } else {
      // include body to help debugging server errors
      throw ServerException(
        'Failed to load products (${response.statusCode}): ${response.body}',
      );
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
      final productJson = decodedJson['data'];

      return ProductModel.fromJson(productJson);
    } else {
      throw ServerException('Failed to load product (${response.statusCode})');
    }
  }

  @override
  Future<Unit> updateProduct(Product product, String id) async {
    final response = await client.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': product.name,
        'description': product.description,
        'price': product.price,
      }),
    );

    if (response.statusCode == 200) {
      return unit;
    } else {
      throw ServerException(
        'Failed to update product (${response.statusCode}): ${response.body}',
      );
    }
  }
}
