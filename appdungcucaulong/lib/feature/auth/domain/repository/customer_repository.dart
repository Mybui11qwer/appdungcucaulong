import '../../data/dto/request/register_request_dto.dart';
import '../entity/customer_entity.dart';

abstract class CustomerRepository {
  Future<Auth> login(String email, String password);
  Future<void> register(RegisterRequestDto dto);
}