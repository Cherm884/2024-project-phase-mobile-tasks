import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product_model.dart';


const cachedProductListKey = 'CACHED_PRODUCT_LIST';

abstract class ProductLocalDataSource {
  /// Gets the cached [List<ProductModel>] which was fetched
  /// the last time the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<List<ProductModel>> getCachedProducts();

  /// Caches a list of [ProductModel] locally.
  Future<void> cacheProduct(List<ProductModel> productsToCache);
}


class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final SharedPreferences sharedPreferences;

  ProductLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheProduct(List<ProductModel> productsToCache) {
    final List<String> jsonList = productsToCache
        .map((product) => json.encode(product.toJson()))
        .toList();

    return sharedPreferences.setStringList(cachedProductListKey, jsonList);
  }

  @override
  Future<List<ProductModel>> getCachedProducts() {
    final jsonStringList = sharedPreferences.getStringList(cachedProductListKey);

    if (jsonStringList != null && jsonStringList.isNotEmpty) {
      final products = jsonStringList
          .map((jsonString) => ProductModel.fromJson(json.decode(jsonString)))
          .toList();

      return Future.value(products);
    } else {
      throw Exception('No cached products found');
    }
  }
}
