import '../../domain/entity/customer_entity.dart';
import '../../domain/repository/customer_repository.dart';
import '../datasource/auth_remote_datasource.dart';
import '../dto/request/register_request_dto.dart';
import '../mapper/login_mapper.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  final AuthRemoteDatasource datasource;

  CustomerRepositoryImpl(this.datasource);

  @override
  Future<Auth> login(String email, String password) async {
    final dto = await datasource.login(email, password);
    return LoginMapper.mapToEntity(dto);
  }

  @override
  Future<void> register(RegisterRequestDto dto) async {
    await datasource.register(dto);
  }
}
