import '../../data/dto/request/register_request_dto.dart';
import '../repository/customer_repository.dart';

class RegisterUseCase {
  final CustomerRepository repository;

  RegisterUseCase(this.repository);

  Future<void> call(RegisterRequestDto dto) {
    return repository.register(dto);
  }
}