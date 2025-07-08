class AddToCartDTO {
  final int productId;
  final int sizeId;
  final int quantity;

  AddToCartDTO({
    required this.productId,
    required this.sizeId,
    required this.quantity,
  });

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'sizeId': sizeId,
    'quantity': quantity,
  };
}
