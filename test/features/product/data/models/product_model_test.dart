import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final testModel = ProductModel(
    id: '1',
    name: 'Test Product',
    description: 'Test Description',
    price: 10.5,
    imageUrl: 'http://test.com/image.png',
  );

  final json = {
    'id': '1',
    'name': 'Test Product',
    'description': 'Test Description',
    'price': 10.5,
    'imageUrl': 'http://test.com/image.png',
  };

  test('fromJson should return valid ProductModel', () {
    final result = ProductModel.fromJson(json);
    expect(result, isA<ProductModel>());
    expect(result.name, 'Test Product');
  });

  test('toJson should return valid map', () {
    final result = testModel.toJson();
    expect(result, json);
  });
}
