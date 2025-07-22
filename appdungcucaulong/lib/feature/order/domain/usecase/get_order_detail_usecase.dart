import 'package:appdungcucaulong/feature/order/domain/entity/order_detail_entity.dart';

import '../repository/order_repository.dart';

class GetOrderDetailUseCase {
  final OrderRepository repository;

  GetOrderDetailUseCase(this.repository);

  Future<List<OrderItemEntity>> call(int orderId) {
    return repository.getOrderDetails(orderId);
  }
}