import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entites/product.dart';
import '../repositories/product_repository.dart';

class CreateProductParams {
  final Product product;
  final String imagePath;

  CreateProductParams({required this.product, required this.imagePath});
}

class CreateProductUsecase extends UseCase<Unit, CreateProductParams> {
  final ProductRepository repository;

  CreateProductUsecase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(CreateProductParams params) {
    return repository.createProduct(params.product, params.imagePath);
  }
}
