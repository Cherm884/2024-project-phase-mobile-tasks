import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';

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
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDataSource.getAllProducts();
        await localDataSource.cacheProduct(remoteProducts.cast<ProductModel>());
        return Right(remoteProducts);
      } on ServerException {
        return const Left(ServerFailure('Failed to fetch data from server'));
      }
    } else {
      try {
        final localProducts = await localDataSource.getCachedProducts();
        return Right(localProducts);
      } on CacheException {
        return const Left(CacheFailure('Failed to fetch from cache'));
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> createProduct(Product product,String imagePath) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.createProduct(product,imagePath);
        return const Right(unit);
      } on ServerException {
        return const Left(ServerFailure('Failed to create product on server'));
      }
    } else {
      return const Left(ServerFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteProduct(String id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteProduct(id);
        return const Right(unit);
      } on ServerException {
        return const Left(ServerFailure('Failed to delete product'));
      }
    } else {
      return const Left(ServerFailure('No internet connection'));
    }
  }

@override
Future<Either<Failure, Product>> getProductById(String id) async {
  
  if (await networkInfo.isConnected) {
    try {
      final product = await remoteDataSource.getProductById(id);
      return Right(product);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  } else {
    debugPrint('[ProductRepository] No network connection');
    return const Left(ServerFailure('No internet connection'));
  }
}

  @override
  Future<Either<Failure, Unit>> updateProduct(Product product,String id) async {
    if (await networkInfo.isConnected) {
      try {

        await remoteDataSource.updateProduct(product,id);
        return const Right(unit);
      } on ServerException {
        return const Left(ServerFailure('Failed to update product'));
      }
    } else {
      return const Left(ServerFailure('No internet connection'));
    }
  }
}
