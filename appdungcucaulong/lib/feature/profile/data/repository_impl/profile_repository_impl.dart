import '../../domain/entity/user_entity.dart';
import '../../domain/repository/profile_repository.dart';
import '../datasource/profile_remote_datasource.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDatasource remote;

  ProfileRepositoryImpl({required this.remote});

  @override
  Future<UserEntity> getUserProfile() async {
    final dto = await remote.getUserProfile();
    return dto.toEntity();
  }
}
