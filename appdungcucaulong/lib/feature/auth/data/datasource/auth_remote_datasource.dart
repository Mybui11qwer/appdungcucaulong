import '../dto/request/register_request_dto.dart';
import '../dto/respone/login_respone_dto.dart';

abstract class AuthRemoteDatasource {
  Future<LoginResponseDto> login(String email, String password);
  Future<void> register(RegisterRequestDto dto);
}