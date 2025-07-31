import 'dart:convert';

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
      'should perform a GET request and return list of ProductModel',
      () async {
        // arrange
        when(
          mockHttpClient.get(
            Uri.parse('http://your.api/products'),
            headers: {'Content-Type': 'application/json'},
          ),
        ).thenAnswer((_) async => http.Response(tJsonList, 200));

        final result = await dataSource.getAllProducts();

        // assert
        expect(result, equals(tProductList));

        verify(
          mockHttpClient.get(
            Uri.parse('http://your.api/products'),
            headers: {'Content-Type': 'application/json'},
          ),
        );
      },
    );

    test(
      'should return list of ProductModel when status code is 200',
      () async {
        // arrange
        when(
          mockHttpClient.get(
            Uri.parse('http://your.api/products'),
            headers: {'Content-Type': 'application/json'},
          ),
        ).thenAnswer((_) async => http.Response(tJsonList, 200));

        // act
        final result = await dataSource.getAllProducts();

        // assert
        expect(result, equals(tProductList));
        verify(
          mockHttpClient.get(
            Uri.parse('http://your.api/products'),
            headers: {'Content-Type': 'application/json'},
          ),
        ).called(1);
      },
    );

    test(
      'should throw ServerException when the response code is 404 or other',
      () async {
        // arrange
        when(
          mockHttpClient.get(
            Uri.parse('http://your.api/products'),
            headers: {'Content-Type': 'application/json'},
          ),
        ).thenAnswer((_) async => http.Response('Not Found', 404));

        // act
        final call = dataSource.getAllProducts;

        // assert
        expect(() => call(), throwsA(isA<ServerException>()));
        verify(
          mockHttpClient.get(
            Uri.parse('http://your.api/products'),
            headers: {'Content-Type': 'application/json'},
          ),
        ).called(1);
      },
    );
  });
}
