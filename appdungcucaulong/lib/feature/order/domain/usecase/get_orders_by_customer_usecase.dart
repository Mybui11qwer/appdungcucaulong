import '../entity/order_entity.dart';
import '../repository/order_repository.dart';

class GetOrdersByCustomerUseCase {
  final OrderRepository repository;

  GetOrdersByCustomerUseCase(this.repository);

  Future<List<OrderEntity>> call(int customerId) {
    return repository.getOrdersByCustomer(customerId);
  }
}