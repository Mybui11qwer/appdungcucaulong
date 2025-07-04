import 'dart:convert';
import 'package:http/http.dart' as http;
import '../dto/respone/login_respone_dto.dart';
import '../../../../core/network/api_constants.dart';

class LoginRemoteDatasource {
  Future<LoginResponseDto> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(ApiConstants.login),
      body: json.encode({"email": email, "password": password}),
      headers: {"Content-Type": "application/json"},
    );

    return LoginResponseDto.fromJson(json.decode(response.body));
  }
}