import '../dto/user_dto.dart';
import '../../domain/entity/user_entity.dart';

extension UserDtoMapper on UserDto {
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      username: username,
      email: email,
      phone: phone,
      address: address,
      gender: gender,
      avatar: avatar,
      role: role,
    );
  }
}
