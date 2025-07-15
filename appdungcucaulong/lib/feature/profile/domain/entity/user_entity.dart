class UserEntity {
  final int id;
  final String username;
  final String email;
  final String? phone;
  final String? address;
  final String? gender;
  final String? avatar;
  final String role;

  UserEntity({
    required this.id,
    required this.username,
    required this.email,
    this.phone,
    this.address,
    this.gender,
    this.avatar,
    required this.role,
  });
}
