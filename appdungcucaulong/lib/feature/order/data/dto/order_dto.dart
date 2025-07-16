import '../../domain/entity/order_entity.dart';

class OrderDto {
  final int id;
  final int customerId;
  final DateTime? orderDate;
  final double total;
  final String status;
  final int? saleId;
  final String paymentMethod;
  final String shippingAddress;

  OrderDto({
    required this.id,
    required this.customerId,
    this.orderDate,
    required this.total,
    required this.status,
    this.saleId,
    required this.paymentMethod,
    required this.shippingAddress,
  });

  factory OrderDto.fromJson(Map<String, dynamic> json) {
    return OrderDto(
      id: json['ID_Order'],
      customerId: json['ID_Customer'],
      orderDate: json['Order_Date'] != null ? DateTime.parse(json['Order_Date']) : null,
      total: (json['Total'] as num).toDouble(),
      status: json['Status'] ?? '',
      saleId: json['ID_Sale'],
      paymentMethod: json['PaymentMethod'] ?? '',
      shippingAddress: json['ShippingAddress'] ?? '',
    );
  }

  OrderEntity toEntity() {
    return OrderEntity(
      id: id,
      customerId: customerId,
      orderDate: orderDate,
      total: total,
      status: status,
      saleId: saleId,
      paymentMethod: paymentMethod,
      shippingAddress: shippingAddress,
      items: [],
    );
  }

  static OrderDto fromDetailJson(Map<String, dynamic> json) {
    return OrderDto.fromJson(json);
  }

  OrderEntity toEntityWithItems(int orderId, [List<OrderItemEntity> items = const []]) {
    return OrderEntity(
      id: orderId,
      customerId: customerId,
      orderDate: orderDate,
      total: total,
      status: status,
      saleId: saleId,
      paymentMethod: paymentMethod,
      shippingAddress: shippingAddress,
      items: items,
    );
  }
}
