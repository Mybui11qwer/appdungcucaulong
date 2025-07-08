import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/network/api_constants.dart';
import '../dto/request/register_request_dto.dart';
import '../dto/respone/login_respone_dto.dart';
import 'auth_remote_datasource.dart';

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  @override
  Future<LoginResponseDto> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(ApiConstants.login),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      return LoginResponseDto.fromJson(json.decode(response.body));
    } else {
      throw Exception("Login failed: ${response.body}");
    }
  }

  @override
  Future<void> register(RegisterRequestDto dto) async {
    final response = await http.post(
      Uri.parse(ApiConstants.register),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(dto.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Register failed: ${response.body}');
    }
  }
}
