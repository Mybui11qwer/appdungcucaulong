class LoginResponseDto {
  final String token;
  final String email;
  final int customerId;

  LoginResponseDto({required this.customerId, required this.token, required this.email});

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) =>
      LoginResponseDto(
        customerId: json['user']?['ID_Customer'] ?? 0,
        token: json['token'] ?? '',
        email: json['user']?['Email'] ?? '',
      );
}