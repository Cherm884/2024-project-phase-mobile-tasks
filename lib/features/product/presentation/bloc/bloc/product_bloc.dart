import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../domain/entites/product.dart';
import '../../../domain/usecases/create_product.dart';

import '../../../domain/usecases/delete_product.dart';
import '../../../domain/usecases/update_product.dart';
import '../../../domain/usecases/view_all_product.dart';
import '../../../domain/usecases/view_spacific_product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ViewAllProductsUsecase viewAllProductsUsecase;
  final ViewProductUsecase viewProductUsecase;
  final CreateProductUsecase createProductUsecase;
  final UpdateProductUsecase updateProductUsecase;
  final DeleteProductUsecase deleteProductUsecase;

  ProductBloc({
    required this.viewAllProductsUsecase,
    required this.viewProductUsecase,
    required this.createProductUsecase,
    required this.updateProductUsecase,
    required this.deleteProductUsecase,
  }) : super(ProductInitial()) {
    on<LoadAllProductsEvent>(_onLoadAllProducts);
    on<GetSingleProductEvent>(_onGetSingleProduct);
    on<CreateProductEvent>(_onCreateProduct);
    on<UpdateProductEvent>(_onUpdateProduct);
    on<DeleteProductEvent>(_onDeleteProduct);
  }

  Future<void> _onLoadAllProducts(
    LoadAllProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(LoadingState());

    try {
      final result = await viewAllProductsUsecase(NoParams());
      result.fold(
        (failure) {
          emit(ErrorState(failure.message));
        },
        (products) {
          emit(LoadedAllProductsState(products));
        },
      );
    } catch (e) {
      emit(const ErrorState('Unexpected error occurred'));
    }
  }

  Future<void> _onGetSingleProduct(
    GetSingleProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(LoadingState());
    try {
      final result = await viewProductUsecase(event.id);

      result.fold(
        (failure) {
          emit(ErrorState(failure.message));
        },
        (product) {
          emit(LoadedSingleProductState(product));
        },
      );
    } catch (e) {
      emit(ErrorState('Unexpected error: $e'));
    }
  }

  Future<void> _onCreateProduct(
    CreateProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(LoadingState());

    final product = Product(
      id: '',
      name: event.name,
      description: event.description,
      price: event.price,
      imageUrl: '',
    );

    final result = await createProductUsecase.call(
      CreateProductParams(product: product, imagePath: event.imagePath),
    );

    result.fold((failure) => emit(ErrorState(failure.message)), (_) {
      emit(ProductSuccess());
      add(LoadAllProductsEvent());
    });
  }

  Future<void> _onUpdateProduct(
    UpdateProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(LoadingState());

    final product = Product(
      id: event.id,
      name: event.name,
      description: event.description,
      price: event.price,
      imageUrl: '',
    );

    final result = await updateProductUsecase(
      UpdateProductParams(product: product, id: event.id),
    );

    result.fold((failure) => emit(ErrorState(failure.message)), (_) {
      emit(ProductSuccess());
      add(LoadAllProductsEvent());
    });
  }

  Future<void> _onDeleteProduct(
    DeleteProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(LoadingState());
    final result = await deleteProductUsecase(event.id);
    result.fold((failure) => emit(ErrorState(failure.message)), (_) {
      emit(DeleteSuccessState(event.id));
      add(LoadAllProductsEvent());
    });
  }
}
