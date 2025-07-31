import 'package:appdungcucaulong/feature/order/domain/entity/order_detail_entity.dart';

import '../../domain/entity/order_entity.dart';
import '../../domain/repository/order_repository.dart';
import '../datasource/order_remote_datasource.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDatasource remoteDatasource;

  OrderRepositoryImpl({required this.remoteDatasource});

  @override
  Future<OrderEntity> createOrder(
      int customerId,
      List<Map<String, dynamic>> products, {
        required double total,
        required String paymentMethod,
        required String shippingAddress,
        int? saleId,
      }) async {
    return await remoteDatasource.createOrder(
      customerId: customerId,
      products: products,
      total: total,
      paymentMethod: paymentMethod,
      shippingAddress: shippingAddress,
      saleId: saleId,
    );
  }

  @override
  Future<void> cancelOrder(int orderId) {
    return remoteDatasource.cancelOrder(orderId);
  }

  @override
  Future<List<OrderEntity>> getOrdersByCustomer(int customerId) async {
    return await remoteDatasource.getOrdersByCustomer(customerId);
  }

  @override
  Future<List<OrderItemEntity>> getOrderDetails(int orderId) async {
    return await remoteDatasource.getOrderDetails(orderId);
  }
}