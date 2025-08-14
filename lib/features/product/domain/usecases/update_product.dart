import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entites/product.dart';
import '../repositories/product_repository.dart';


class UpdateProductParams {
  final Product product;
  final String id;

  UpdateProductParams({required this.product, required this.id});
}


class UpdateProductUsecase extends UseCase<Unit, UpdateProductParams>{
  final ProductRepository repository;

  UpdateProductUsecase(this.repository);

  
  @override
  Future<Either<Failure, Unit>> call(UpdateProductParams params) {
    return repository.updateProduct(params.product,params.id);
  }
}
