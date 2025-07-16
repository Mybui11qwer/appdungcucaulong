import '../entity/order_entity.dart';
import '../repository/order_repository.dart';

class GetOrderDetailUseCase {
  final OrderRepository repository;

  GetOrderDetailUseCase(this.repository);

  Future<OrderEntity> call(int orderId) {
    return repository.getOrderDetail(orderId);
  }
}