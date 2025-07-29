import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entites/product.dart';
import '../repositories/product_repository.dart';

class UpdateProductUsecase extends UseCase<void, Product>{
  final ProductRepository repository;

  UpdateProductUsecase(this.repository);

  
  @override
  Future<Either<Failure, Unit>> call(Product product) {
    return repository.updateProduct(product);
  }
}
