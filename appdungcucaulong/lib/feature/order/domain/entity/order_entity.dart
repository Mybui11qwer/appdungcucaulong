class OrderEntity {
  final int id;
  final int customerId;
  final DateTime? orderDate;
  final double total;
  final String status;
  final int? saleId;
  final String paymentMethod;
  final String shippingAddress;

  OrderEntity({
    required this.id,
    required this.customerId,
    this.orderDate,
    required this.total,
    required this.status,
    this.saleId,
    required this.paymentMethod,
    required this.shippingAddress,
  });
}