import '../entity/user_entity.dart';

abstract class ProfileRepository {
  Future<UserEntity> getUserProfile();
}
