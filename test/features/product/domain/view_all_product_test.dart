import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/product/domain/entites/product.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repository.dart';
import 'package:ecommerce_app/features/product/domain/usecases/view_all_product.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';


import 'view_all_product_test.mocks.dart';

@GenerateMocks([ProductRepository])
void main() {
  late MockProductRepository mockRepository;
  late ViewAllProductsUsecase usecase;

  setUp(() {
    mockRepository = MockProductRepository();
    usecase = ViewAllProductsUsecase(mockRepository);
  });

  final tProducts = [
     Product(
      id: '1',
      name: 'Phone',
      description: 'Smartphone',
      imageUrl: 'phone.jpg',
      price: 499.99,
    ),
  ];

  test('should return a list of products from the repository', () async {
    // Arrange
    when(mockRepository.getAllProducts())
        .thenAnswer((_) async => Right(tProducts));

    // Act
    final result = await usecase();

    // Assert
    expect(result, Right(tProducts));
    verify(mockRepository.getAllProducts());
    verifyNoMoreInteractions(mockRepository);
  });
}
