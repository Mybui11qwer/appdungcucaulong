import 'package:appdungcucaulong/feature/order/domain/entity/order_detail_entity.dart';

import '../entity/order_entity.dart';

abstract class OrderRepository {
  Future<OrderEntity> createOrder(
      int customerId,
      List<Map<String, dynamic>> products, {
        required double total,
        required String paymentMethod,
        required String shippingAddress,
        int? saleId,
      });

  Future<List<OrderEntity>> getOrdersByCustomer(int customerId);

  Future<List<OrderItemEntity>> getOrderDetails(int orderId);
}