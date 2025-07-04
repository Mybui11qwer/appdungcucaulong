import '../../domain/entity/customer_entity.dart';
import '../../domain/repository/customer_repository.dart';
import '../datasource/login_remote_datasource.dart';
import '../mapper/login_mapper.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDatasource datasource;

  LoginRepositoryImpl(this.datasource);

  @override
  Future<Auth> login(String email, String password) async {
    final dto = await datasource.login(email, password);
    return LoginMapper.mapToEntity(dto);
  }
}