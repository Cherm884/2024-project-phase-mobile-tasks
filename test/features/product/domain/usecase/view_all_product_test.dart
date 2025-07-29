import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/features/product/domain/entites/product.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repository.dart';
import 'package:ecommerce_app/features/product/domain/usecases/view_all_product.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../../../mocks/mock_product_repository.mocks.dart';




void main() {
  late MockProductRepository mockRepository;
  late ViewAllProductsUsecase usecase;

  setUp(() {
    mockRepository = MockProductRepository();
    usecase = ViewAllProductsUsecase(mockRepository);
  });

  final testProduct = [
    Product(
      id: '1',
      name: 'Phone',
      description: 'a smartPhone',
      price: 499.99,
      imageUrl: 'phone.jpg',
    ),
    Product(
      id: '2',
      name: 'Prod2',
      description: 'Desc2',
      price: 30,
      imageUrl: 'url2.png',
    ),
  ];

  test('should return list of products from repository', () async {
    when(
      mockRepository.getAllProducts(),
    ).thenAnswer((_) async => Right(testProduct));

    final result = await usecase(NoParams());

    expect(result, Right(testProduct));
    verify(mockRepository.getAllProducts());
    verifyNoMoreInteractions(mockRepository);
  });
}
