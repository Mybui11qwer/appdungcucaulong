import '../../domain/entity/customer_entity.dart';
import '../dto/respone/login_respone_dto.dart';

class LoginMapper {
  static Auth mapToEntity(LoginResponseDto dto) {
    return Auth(customerId: dto.customerId ,email: dto.email, token: dto.token);
  }
}