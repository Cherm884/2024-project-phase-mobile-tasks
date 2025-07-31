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

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<Unit> createProduct(Product product) {
    // TODO: implement createProduct
    throw UnimplementedError();
  }

  @override
  Future<Unit> deleteProduct(String id) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getAllProducts() async {
    final response = await client.get(
      Uri.parse('http://your.api/products'), // Replace with your real endpoint
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
  Future<Product> getProductById(String id) {
    // TODO: implement getProductById
    throw UnimplementedError();
  }

  @override
  Future<Unit> updateProduct(Product product) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }
}
