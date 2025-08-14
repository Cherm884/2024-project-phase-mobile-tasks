import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entites/product.dart';


abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getAllProducts();
  Future<Either<Failure, Product>> getProductById(String id);
  Future<Either<Failure, Unit>> createProduct(Product product, String imagePath);
  Future<Either<Failure, Unit>> updateProduct(Product product,String id);
  Future<Either<Failure, Unit>> deleteProduct(String id);
}
