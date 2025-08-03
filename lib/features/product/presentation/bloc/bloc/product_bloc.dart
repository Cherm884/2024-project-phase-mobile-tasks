import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
    final result = await viewAllProductsUsecase(NoParams());
    result.fold(
      (failure) => emit(ErrorState(failure.message)),
      (products) => emit(LoadedAllProductsState(products)),
    );
  }

  Future<void> _onGetSingleProduct(
    GetSingleProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(LoadingState());
    final result = await viewProductUsecase(event.id);
    result.fold(
      (failure) => emit(ErrorState(failure.message)),
      (product) => emit(LoadedSingleProductState(product)),
    );
  }

  Future<void> _onCreateProduct(
    CreateProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(LoadingState());
    final result = await createProductUsecase(event.product);
    result.fold(
      (failure) => emit(ErrorState(failure.message)),
      (_) => add(LoadAllProductsEvent()),
    );
  }

  Future<void> _onUpdateProduct(
    UpdateProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(LoadingState());
    final result = await updateProductUsecase(event.product);
    result.fold(
      (failure) => emit(ErrorState(failure.message)),
      (_) => add(LoadAllProductsEvent()),
    );
  }

  Future<void> _onDeleteProduct(
    DeleteProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(LoadingState());
    final result = await deleteProductUsecase(event.id);
    result.fold(
      (failure) => emit(ErrorState(failure.message)),
      (_) => add(LoadAllProductsEvent()),
    );
  }
}
