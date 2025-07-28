import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entites/product.dart';
import '../repositories/product_repository.dart';

class DeleteProductUsecase {
  final ProductRepository repository;

  DeleteProductUsecase(this.repository);

  Future<Either<Failure, Product>> e(String id) {
    return repository.deleteProduct(id);
  }
}
