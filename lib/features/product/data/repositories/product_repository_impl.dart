import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entites/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_data_source.dart';
import '../datasources/product_remote_data_source.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, Unit>> createProduct(Product product) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> deleteProduct(String id) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final remote = await remoteDataSource.getAllProducts();
        await localDataSource.cacheProduct(remote as ProductModel);
        return Right(remote);
      } on ServerException {
        return const Left(ServerFailure('Failed to fetch data from server'));
      }
    } else {
      try {
        final local = await localDataSource.getLastProduct();
        return Right(local as List<Product>);
      } on CacheException {
        return const Left(CacheFailure('fail the cache'));
      }
    }
  }

  @override
  Future<Either<Failure, Product>> getProductById(String id) {
    // TODO: implement getProductById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> updateProduct(Product product) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }
}
