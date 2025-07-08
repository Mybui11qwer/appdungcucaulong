import '../../data/dto/request/add_to_cart_dto.dart';

abstract class CartEvent {}

class LoadCartEvent extends CartEvent {}

class AddToCartEvent extends CartEvent {
  final AddToCartDTO dto;
  AddToCartEvent(this.dto);
}

class RemoveFromCartEvent extends CartEvent {
  final int cartItemId;

  RemoveFromCartEvent(this.cartItemId);
}