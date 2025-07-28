import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entites/product.dart';
import '../repositories/product_repository.dart';

class ViewAllProductsUsecase {
  late final ProductRepository repository;

  ViewAllProductsUsecase(this.repository);

  Future<Either<Failure, List<Product>>> call() {
    return repository.getAllProducts();
  }
  
}
