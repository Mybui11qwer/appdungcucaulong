import '../../domain/entity/customer_entity.dart';

abstract class LoginRepository {
  Future<Auth> login(String email, String password);
}