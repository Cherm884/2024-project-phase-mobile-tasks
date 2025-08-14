part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class LoadAllProductsEvent extends ProductEvent {}

class GetSingleProductEvent extends ProductEvent {
  final String id;

  const GetSingleProductEvent(this.id);

  @override
  List<Object> get props => [id];
}

class UpdateProductEvent extends ProductEvent {
  final String id;
  final String name;
  final String description;
  final double price;

  const UpdateProductEvent({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
  });
}

class DeleteProductEvent extends ProductEvent {
  final String id;

  const DeleteProductEvent(this.id);

  @override
  List<Object> get props => [id];
}

class CreateProductEvent extends ProductEvent {
  final String name;
  final String description;
  final double price;
  final String imagePath;

  const CreateProductEvent({
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
  });
}
