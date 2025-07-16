class OrderEntity {
  final int id;
  final int customerId;
  final DateTime? orderDate;
  final double total;
  final String status;
  final int? saleId;
  final String paymentMethod;
  final String shippingAddress;
  final List<OrderItemEntity> items;

  OrderEntity({
    required this.id,
    required this.customerId,
    this.orderDate,
    required this.total,
    required this.status,
    this.saleId,
    required this.paymentMethod,
    required this.shippingAddress,
    required this.items,
  });
}

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
}