import '../entity/customer_entity.dart';

abstract class CustomerRepository {
  Future<List<CustomerEntity>> getCustomer();
}