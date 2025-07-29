import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/features/product/domain/entites/product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/create_product.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../../../mocks/mock_product_repository.mocks.dart';

void main() {
  late MockProductRepository mockRepository;
  late CreateProductUsecase usecase;

  setUp(() {
    mockRepository = MockProductRepository();
    usecase = CreateProductUsecase(mockRepository);
  });
  final product = Product(
    id: '1',
    name: 'Test',
    description: 'Desc',
    price: 100.0,
    imageUrl: 'http://image.com/test.jpg',
  );
  test('should insert product via repository', () async {
    when(
      mockRepository.createProduct(product),
    ).thenAnswer((_) async => const Right(unit));

    final result = await usecase(product);

    expect(result,  const Right(unit));
    verify(mockRepository.createProduct(product));
    verifyNoMoreInteractions(mockRepository);
  });
}
