import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entites/product.dart';
import '../repositories/product_repository.dart';

class ViewProductUsecase extends UseCase<Product, String>{
  final ProductRepository repository;

  ViewProductUsecase(this.repository);

  @override
  Future<Either<Failure, Product>> call(String id) {
    return repository.getProductById(id);
  }
}
