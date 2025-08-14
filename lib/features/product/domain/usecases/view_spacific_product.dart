import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entites/product.dart';
import '../repositories/product_repository.dart';

class ViewProductUsecase extends UseCase<Product, String> {
  final ProductRepository repository;

  ViewProductUsecase(this.repository);

  @override
  Future<Either<Failure, Product>> call(String id) async {
    debugPrint('[Usecase] view product id=$id');
    final res = await repository.getProductById(id);
    debugPrint('[Usecase] repository.getProductById returned');
    return res;
  }
}
