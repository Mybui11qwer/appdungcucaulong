
import '../entity/order_entity.dart';
import '../repository/order_repository.dart';

class CreateOrderUseCase {
  final OrderRepository repository;

  CreateOrderUseCase(this.repository);

  Future<OrderEntity>call(
      int customerId,
      List<Map<String, dynamic>> products, {
        required double total,
        required String paymentMethod,
        required String shippingAddress,
        int? saleId,
      }) {
    return repository.createOrder(
      customerId,
      products,
      total: total,
      paymentMethod: paymentMethod,
      shippingAddress: shippingAddress,
      saleId: saleId,
    );
  }
}