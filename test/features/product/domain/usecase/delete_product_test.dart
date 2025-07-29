import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/product/domain/usecases/delete_product.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../../../mocks/mock_product_repository.mocks.dart';

void main() {
  late DeleteProductUsecase usecase;
  late MockProductRepository mockRepo;

  setUp(() {
    mockRepo = MockProductRepository();
    usecase = DeleteProductUsecase(mockRepo);
  });

  const String id = '1';

  test('should delete product via repository', () async {
    when(mockRepo.deleteProduct(id)).thenAnswer((_) async => const Right(unit));

    final result = await usecase(id);

    expect(result, const Right(unit));
    verify(mockRepo.deleteProduct(id));
    verifyNoMoreInteractions(mockRepo);
  });
}