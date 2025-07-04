import '../../domain/entity/customer_entity.dart';
import '../../domain/repository/customer_repository.dart';
import '../datasource/customer_datasource.dart';

abstract class CustomerReposityImpl implements CustomerRepository {
  final CustomerDatasource remoteDatasource;

  CustomerReposityImpl(this.remoteDatasource);

  @override
  Future<List<CustomerEntity>> getCustomer() async {
    return await remoteDatasource.authCustomerLogin();
  }
}