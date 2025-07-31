import 'dart:convert';

import 'package:ecommerce_app/features/product/data/datasources/product_local_data_source.dart';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'product_local_data_source.mocks.dart';



@GenerateMocks([SharedPreferences])

void main() {
  late ProductLocalDataSourceImpl datasource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    datasource = ProductLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  final tProductModel = ProductModel(
    id: '1',
    name: 'Test Product',
    description: 'A product for testing',
    price: 100,
    imageUrl: 'test.png',
  );

  final tProductList = [tProductModel];
  final tJsonList = tProductList.map((product) => json.encode(product.toJson())).toList();

  group('cacheProduct', () {
    test('should call SharedPreferences to cache the product list', () async {
      // Arrange
      when(mockSharedPreferences.setStringList(any, any)).thenAnswer((_) async => true);

      // Act
      await datasource.cacheProduct(tProductList);

      // Assert
      verify(mockSharedPreferences.setStringList('CACHED_PRODUCT_LIST', tJsonList));
    });
  });

  group('getCachedProducts', () {
    test('should return list of ProductModel when there is cached data', () async {
      // Arrange
      when(mockSharedPreferences.getStringList('CACHED_PRODUCT_LIST'))
          .thenReturn(tJsonList);

      // Act
      final result = await datasource.getCachedProducts();

      // Assert
      expect(result, equals(tProductList));
    });

    test('should throw Exception when there is no cached data', () async {
      // Arrange
      when(mockSharedPreferences.getStringList('CACHED_PRODUCT_LIST'))
          .thenReturn(null);

      // Act & Assert
      expect(() => datasource.getCachedProducts(), throwsException);
    });
  });
}
