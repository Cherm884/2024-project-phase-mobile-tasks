import 'dart:core';

import 'package:dartz/dartz.dart';

import '../../domain/entites/product.dart';

abstract class ProductRemoteDataSource {

  /// Throws a [ServerException] for all error codes.
  Future<List<Product>> getAllProducts();

  /// Throws a [ServerException] for all error codes.
  Future< Product> getProductById(String id);

  /// Throws a [ServerException] for all error codes.
  Future<Unit> createProduct(Product product);

  /// Throws a [ServerException] for all error codes.
  Future<Unit> updateProduct(Product product);

  /// Throws a [ServerException] for all error codes.
  Future<Unit> deleteProduct(String id);
}