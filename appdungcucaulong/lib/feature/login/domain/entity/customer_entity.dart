class CustomerEntity {
  final int id;
  final String  username;
  final String  email;
  final String password;
  final String role;
  final String avatar;

  CustomerEntity({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.role,
    required this.avatar,
  });
}