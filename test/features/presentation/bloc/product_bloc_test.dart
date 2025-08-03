import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failures.dart';
import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/features/product/domain/entites/product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/create_product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/delete_product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/update_product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/view_all_product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/view_spacific_product.dart';
import 'package:ecommerce_app/features/product/presentation/bloc/bloc/product_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'product_bloc_test.mocks.dart';

@GenerateMocks([
  ViewAllProductsUsecase,
  ViewProductUsecase,
  CreateProductUsecase,
  UpdateProductUsecase,
  DeleteProductUsecase,
])
void main() {
  late ProductBloc bloc;
  late MockViewAllProductsUsecase mockViewAll;
  late MockViewProductUsecase mockViewOne;
  late MockCreateProductUsecase mockCreate;
  late MockUpdateProductUsecase mockUpdate;
  late MockDeleteProductUsecase mockDelete;

  setUp(() {
    mockViewAll = MockViewAllProductsUsecase();
    mockViewOne = MockViewProductUsecase();
    mockCreate = MockCreateProductUsecase();
    mockUpdate = MockUpdateProductUsecase();
    mockDelete = MockDeleteProductUsecase();

    bloc = ProductBloc(
      viewAllProductsUsecase: mockViewAll,
      viewProductUsecase: mockViewOne,
      createProductUsecase: mockCreate,
      updateProductUsecase: mockUpdate,
      deleteProductUsecase: mockDelete,
    );
  });

  final tProduct = Product(
    id: '1',
    name: 'Test Product',
    description: 'Test Description',
    price: 100,
    imageUrl: 'https://test.com/image.jpg',
  );

  final tProductList = [tProduct];

  group('LoadAllProductsEvent', () {
    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, LoadedAllProductsState] on success',
      build: () {
        when(mockViewAll.call(any))
            .thenAnswer((_) async => Right(tProductList));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadAllProductsEvent()),
      expect: () => [
        LoadingState(),
        LoadedAllProductsState(tProductList),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, ErrorState] on failure',
      build: () {
        when(mockViewAll.call(any))
            .thenAnswer((_) async => const Left(ServerFailure('failed')));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadAllProductsEvent()),
      expect: () => [
        LoadingState(),
        const ErrorState('failed'),
      ],
    );
  });

  group('GetSingleProductEvent', () {
    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, LoadedSingleProductState] on success',
      build: () {
        when(mockViewOne.call('1')).thenAnswer((_) async => Right(tProduct));
        return bloc;
      },
      act: (bloc) => bloc.add(const GetSingleProductEvent('1')),
      expect: () => [
        LoadingState(),
        LoadedSingleProductState(tProduct),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, ErrorState] on failure',
      build: () {
        when(mockViewOne.call('1'))
            .thenAnswer((_) async => const Left(ServerFailure('not found')));
        return bloc;
      },
      act: (bloc) => bloc.add(const GetSingleProductEvent('1')),
      expect: () => [
        LoadingState(),
        const ErrorState('not found'),
      ],
    );
  });

  group('CreateProductEvent', () {
    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState] when creation is successful',
      build: () {
        when(mockCreate.call(tProduct))
            .thenAnswer((_) async => const Right(unit));
        when(mockViewAll.call(any)) // needed in case LoadAllProductsEvent is called
            .thenAnswer((_) async => Right(tProductList));
        return bloc;
      },
      act: (bloc) => bloc.add(CreateProductEvent(tProduct)),
      expect: () => [
        LoadingState(),
        LoadedAllProductsState(tProductList),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, ErrorState] when creation fails',
      build: () {
        when(mockCreate.call(tProduct))
            .thenAnswer((_) async => const Left(ServerFailure('create failed')));
        return bloc;
      },
      act: (bloc) => bloc.add(CreateProductEvent(tProduct)),
      expect: () => [
        LoadingState(),
        const ErrorState('create failed'),
      ],
    );
  });

  group('UpdateProductEvent', () {
    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState] when update is successful',
      build: () {
        when(mockUpdate.call(tProduct))
            .thenAnswer((_) async => const Right(unit));
        when(mockViewAll.call(any))
            .thenAnswer((_) async => Right(tProductList));
        return bloc;
      },
      act: (bloc) => bloc.add(UpdateProductEvent(tProduct)),
      expect: () => [
        LoadingState(),
        LoadedAllProductsState(tProductList),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, ErrorState] when update fails',
      build: () {
        when(mockUpdate.call(tProduct))
            .thenAnswer((_) async => const Left(ServerFailure('update failed')));
        return bloc;
      },
      act: (bloc) => bloc.add(UpdateProductEvent(tProduct)),
      expect: () => [
        LoadingState(),
        const ErrorState('update failed'),
      ],
    );
  });

  group('DeleteProductEvent', () {
    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState] when delete is successful',
      build: () {
        when(mockDelete.call('1')).thenAnswer((_) async => const Right(unit));
        when(mockViewAll.call(any))
            .thenAnswer((_) async => Right(tProductList));
        return bloc;
      },
      act: (bloc) => bloc.add(const DeleteProductEvent('1')),
      expect: () => [
        LoadingState(),
        LoadedAllProductsState(tProductList),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, ErrorState] when delete fails',
      build: () {
        when(mockDelete.call('1'))
            .thenAnswer((_) async => const Left(ServerFailure('delete failed')));
        return bloc;
      },
      act: (bloc) => bloc.add(const DeleteProductEvent('1')),
      expect: () => [
        LoadingState(),
        const ErrorState('delete failed'),
      ],
    );
  });
}
