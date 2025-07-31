import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/exceptions.dart';
import 'package:ecommerce_app/features/product/data/datasources/product_remote_data_source.dart';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'product_remote_data_source_test.mocks.dart'; // generated

@GenerateMocks([http.Client])
void main() {
  late ProductRemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;
  final String id = '1';
  const baseUrl =
      'https://g5-flutter-learning-path-be.onrender.com/api/v1/products';

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = ProductRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('getAllProducts', () {
    final tProduct = ProductModel(
      id: '1',
      name: 'Test Product',
      description: 'A product for testing',
      price: 100,
      imageUrl: 'test.png',
    );

    final tProductList = [tProduct];

    final tJsonList = json.encode(tProductList);

    test(
      'should return list of ProductModel when status code is 200',
      () async {
        // arrange
        when(
          mockHttpClient.get(
            Uri.parse(baseUrl),
            headers: {'Content-Type': 'application/json'},
          ),
        ).thenAnswer((_) async => http.Response(tJsonList, 200));

        // act
        final result = await dataSource.getAllProducts();

        // assert
        expect(result, isA<List<ProductModel>>());
        verify(
          mockHttpClient.get(
            Uri.parse(baseUrl),
            headers: {'Content-Type': 'application/json'},
          ),
        );
      },
    );

    test(
      'should throw ServerException when the response code is 404 or other',
      () async {
        // arrange
        when(
          mockHttpClient.get(
            Uri.parse(baseUrl),
            headers: {'Content-Type': 'application/json'},
          ),
        ).thenAnswer((_) async => http.Response('Not Found', 404));

        // act
        final call = dataSource.getAllProducts;

        // assert
        expect(() => call(), throwsA(isA<ServerException>()));
        verify(
          mockHttpClient.get(
            Uri.parse(baseUrl),
            headers: {'Content-Type': 'application/json'},
          ),
        );
      },
    );

    test('should return created product when status code is 200', () async {
      // arrange
      when(
        mockHttpClient.post(
          Uri.parse(baseUrl),
          headers: {'Content-Type': 'application/json'},
          body: anyNamed('body'), 
        ),
      ).thenAnswer((_) async => http.Response('', 200));

      
      when(
        mockHttpClient.get(
          Uri.parse(baseUrl),
          headers: {'Content-Type': 'application/json'},
        ),
      ).thenAnswer((_) async => http.Response('[]', 200));

      // act
      final result = await dataSource.createProduct(tProduct);

      // assert
      expect(result, unit);
    });

    test('should return updated product when status code is 200', () async {
      // arrange
      when(
        mockHttpClient.put(
          Uri.parse(baseUrl),
          headers: {'Content-Type': 'application/json'},
          body: anyNamed('body'),
        ),
      ).thenAnswer((_) async => http.Response('', 200));

      
      when(
        mockHttpClient.get(
          Uri.parse(baseUrl),
          headers: {'Content-Type': 'application/json'},
        ),
      ).thenAnswer((_) async => http.Response('[]', 200));

      // act
      final result = await dataSource.updateProduct(tProduct);

      // assert
      expect(result, unit);
    });

    test(
      'should delete product by id and return unit when successful',
      () async {
        // arrange
        when(
          mockHttpClient.delete(
            Uri.parse('$baseUrl/$id'),
            headers: {'Content-Type': 'application/json'},
          ),
        ).thenAnswer((_) async => http.Response('', 204));

        // act
        final result = await dataSource.deleteProduct('1');

        // assert
        expect(result, unit);
        verify(
          mockHttpClient.delete(
            Uri.parse('$baseUrl/$id'),
            headers: {'Content-Type': 'application/json'},
          ),
        ).called(1);
      },
    );
  });
}
