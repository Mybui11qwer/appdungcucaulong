import '../entity/user_entity.dart';
import '../repository/profile_repository.dart';

class GetUserProfileUseCase {
  final ProfileRepository repository;

  GetUserProfileUseCase(this.repository);

  Future<UserEntity> call() {
    return repository.getUserProfile();
  }
}
