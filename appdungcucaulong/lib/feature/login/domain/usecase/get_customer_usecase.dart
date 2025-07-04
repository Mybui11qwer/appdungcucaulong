import '../entity/customer_entity.dart';
import '../repository/customer_repository.dart';

class GetCustomerUsecase {
  final CustomerRepository repository;

  GetCustomerUsecase(this.repository);

  Future<List<CustomerEntity>> call() {
    return repository.getCustomer();
  }
}