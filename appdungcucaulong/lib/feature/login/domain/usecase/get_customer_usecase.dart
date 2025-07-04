import '../../domain/entity/customer_entity.dart';
import '../repository/customer_repository.dart';

class LoginUseCase {
  final LoginRepository repository;

  LoginUseCase(this.repository);

  Future<Auth> call(String email, String password) {
    return repository.login(email, password);
  }
}