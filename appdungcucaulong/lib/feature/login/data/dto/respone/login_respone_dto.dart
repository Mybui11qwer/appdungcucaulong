class LoginResponseDto {
  final String token;
  final String email;

  LoginResponseDto({required this.token, required this.email});

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) =>
      LoginResponseDto(
        token: json['token'],
        email: json['taiKhoan']['email'],
      );
}