import '../../domain/entity/customer_entity.dart';

class CustomerDto extends CustomerEntity {
  CustomerDto({
    required super.id,
    required super.username,
    required super.email,
    required super.password,
    required super.role,
    required super.avatar,
  });

  factory CustomerDto.fromJson(Map<String, dynamic> json) {
    return CustomerDto(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      role: json['role'],
      avatar: json['avatar'],
    );
  }
}