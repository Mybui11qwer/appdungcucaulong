class CartItemEntity {
  final int id;
  final int productId;
  final int sizeId;
  final int quantity;
  final String productName;
  final String image;
  final double price;
  final String sizeName;

  CartItemEntity({
    required this.id,
    required this.productId,
    required this.sizeId,
    required this.quantity,
    required this.productName,
    required this.image,
    required this.price,
    required this.sizeName,
  });
}
