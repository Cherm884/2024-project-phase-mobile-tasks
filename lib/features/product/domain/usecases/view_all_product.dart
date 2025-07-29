import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entites/product.dart';
import '../repositories/product_repository.dart';

class ViewAllProductsUsecase extends UseCase<List<Product>, NoParams>{
  late final ProductRepository repository;

  ViewAllProductsUsecase(this.repository);

  @override
  Future<Either<Failure, List<Product>>> call(NoParams params) {
    return repository.getAllProducts();
  }
  
}
