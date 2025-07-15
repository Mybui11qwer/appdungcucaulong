import '../../domain/entity/user_entity.dart';

class UserDto {
  final int id;
  final String username;
  final String email;
  final String? phone;
  final String? address;
  final String? gender;
  final String? avatar;
  final String role;

  UserDto({
    required this.id,
    required this.username,
    required this.email,
    this.phone,
    this.address,
    this.gender,
    this.avatar,
    required this.role,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      address: json['address'],
      gender: json['gender'],
      avatar: json['avatar'],
      role: json['role'] ?? 'Customer',
    );
  }

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
