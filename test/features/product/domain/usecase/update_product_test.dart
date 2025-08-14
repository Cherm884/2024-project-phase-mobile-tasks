import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/product/domain/entites/product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/update_product.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../mock_product_repository.mocks.dart';

void main() {
  late UpdateProductUsecase usecase;
  late MockProductRepository mockRepo;

  setUp(() {
    mockRepo = MockProductRepository();
    usecase = UpdateProductUsecase(mockRepo);
  });

  const product = Product(
    id: '1',
    name: 'Updated',
    description: 'New Desc',
    price: 120.0,
    imageUrl: 'http://image.com/updated.jpg',
  );

  final params = UpdateProductParams(
    product: product,
    id: '1',
  );

  test('should update product via repository', () async {
    // Arrange
    when(mockRepo.updateProduct(product, '1'))
        .thenAnswer((_) async => const Right(unit));

    // Act
    final result = await usecase(params);

    // Assert
    expect(result, const Right(unit));
    verify(mockRepo.updateProduct(product, '1'));
    verifyNoMoreInteractions(mockRepo);
  });
}
