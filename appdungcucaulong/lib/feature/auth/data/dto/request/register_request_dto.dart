class RegisterRequestDto {
  final String username;
  final String email;
  final String phone;
  final String password;
  final String role;

  RegisterRequestDto({
    required this.username,
    required this.email,
    required this.phone,
    required this.password,
    this.role = 'customer',
  });

  Map<String, dynamic> toJson() => {
    "username": username,
    "email": email,
    "phone": phone,
    "password": password,
    "role": role,
  };
}