import '../../domain/entity/customer_entity.dart';
import '../dto/respone/login_respone_dto.dart';

class LoginMapper {
  static Auth mapToEntity(LoginResponseDto dto) {
    return Auth(email: dto.email, token: dto.token);
  }
}