class OrderItemEntity {
  final int productId;
  final int sizeId;
  final int quantity;
  final double unitPrice;

  OrderItemEntity({
    required this.productId,
    required this.sizeId,
    required this.quantity,
    required this.unitPrice,
  });

  factory OrderItemEntity.fromJson(Map<String, dynamic> json) {
    return OrderItemEntity(
      productId: json['ID_Product'] ?? 0,
      sizeId: json['ID_Size'] ?? 0,
      quantity: json['Quantity'] ?? 0,
      unitPrice: (json['Unit_Price'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
