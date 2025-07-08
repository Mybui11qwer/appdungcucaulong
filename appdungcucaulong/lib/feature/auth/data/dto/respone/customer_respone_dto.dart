class CustomerDto {
  final int id;
  final String username;
  final String email;
  final String password;
  final String role;
  final String avatar;

  CustomerDto({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.role,
    required this.avatar,
  });

  factory CustomerDto.fromJson(Map<String, dynamic> json) => CustomerDto(
        id: json['id'],
        username: json['username'],
        email: json['email'],
        password: json['password'],
        role: json['role'],
        avatar: json['avatar'],
      );
}