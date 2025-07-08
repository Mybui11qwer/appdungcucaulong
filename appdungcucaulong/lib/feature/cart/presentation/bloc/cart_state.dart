import '../../domain/entity/cart_item_entity.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItemEntity> items;

  CartLoaded(this.items);
}

class CartError extends CartState {
  final String message;

  CartError(this.message);
}