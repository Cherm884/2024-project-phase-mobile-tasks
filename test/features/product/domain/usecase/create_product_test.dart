import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/product/domain/entites/product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/create_product.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../mock_product_repository.mocks.dart';

void main() {
  late MockProductRepository mockRepository;
  late CreateProductUsecase usecase;

  setUp(() {
    mockRepository = MockProductRepository();
    usecase = CreateProductUsecase(mockRepository);
  });

  const product = Product(
    id: '1',
    name: 'Test',
    description: 'Desc',
    price: 100.0,
    imageUrl: 'http://image.com/test.jpg',
  );

  final params = CreateProductParams(
    product: product,
    imagePath: 'path/to/image.jpg',
  );

  test('should insert product via repository', () async {
    // Arrange
    when(mockRepository.createProduct(product, 'path/to/image.jpg'))
        .thenAnswer((_) async => const Right(unit));

    // Act
    final result = await usecase(params);

    // Assert
    expect(result, const Right(unit));
    verify(mockRepository.createProduct(product, 'path/to/image.jpg'));
    verifyNoMoreInteractions(mockRepository);
  });
}
