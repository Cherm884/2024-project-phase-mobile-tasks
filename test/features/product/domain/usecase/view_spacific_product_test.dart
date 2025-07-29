import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/product/domain/entites/product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/view_spacific_product.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../../../mocks/mock_product_repository.mocks.dart';

void main() {
  late ViewProductUsecase usecase;
  late MockProductRepository mockRepo;

  setUp(() {
    mockRepo = MockProductRepository();
    usecase = ViewProductUsecase(mockRepo);
  });

  const String id = '1';
  final product = Product(
    id: id,
    name: 'Test Product',
    description: 'Desc',
    price: 50.0,
    imageUrl: 'http://img.com/1.jpg',
  );

  test('should get product from repository', () async {
    when(mockRepo.getProductById(id)).thenAnswer((_) async => Right(product));

    final result = await usecase(id);

    expect(result, Right(product));
    verify(mockRepo.getProductById(id));
    verifyNoMoreInteractions(mockRepo);
  });
}