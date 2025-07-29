import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/product_repository.dart';

class DeleteProductUsecase extends UseCase<void,String>{
  final ProductRepository repository;

  DeleteProductUsecase(this.repository);

  
  @override
  Future<Either<Failure, Unit>> call(String id) {
    return  repository.deleteProduct(id);
  }
}
