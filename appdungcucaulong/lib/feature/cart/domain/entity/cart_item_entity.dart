import 'package:equatable/equatable.dart';

class CartItemEntity extends Equatable {
  final int cartItemId;
  final int productId;
  final int sizeId;
  final int quantity;
  final String productName;
  final String image;
  final double price;
  final String sizeName;

  // ignore: prefer_const_constructors_in_immutables
  CartItemEntity({
    required this.cartItemId,
    required this.productId,
    required this.sizeId,
    required this.quantity,
    required this.productName,
    required this.image,
    required this.price,
    required this.sizeName,
  });

  CartItemEntity copyWith({
    int? cartItemId,
    int? productId,
    int? sizeId,
    int? quantity,
    String? productName,
    String? image,
    double? price,
    String? sizeName,
  }) {
    return CartItemEntity(
      cartItemId: cartItemId ?? this.cartItemId,
      productId: productId ?? this.productId,
      sizeId: sizeId ?? this.sizeId,
      quantity: quantity ?? this.quantity,
      productName: productName ?? this.productName,
      image: image ?? this.image,
      price: price ?? this.price,
      sizeName: sizeName ?? this.sizeName,
    );
  }

  @override
  List<Object?> get props => [
        cartItemId,
        productId,
        sizeId,
        quantity,
        productName,
        image,
        price,
        sizeName,
      ];
}
