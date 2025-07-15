import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/network/api_constants.dart';
import '../dto/user_dto.dart';

class ProfileRemoteDatasource {
  final http.Client client;

  ProfileRemoteDatasource({required this.client});

  Future<UserDto> getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');

    final response = await client.get(
      Uri.parse(ApiConstants.userProfile),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body)['data'];
      return UserDto.fromJson(jsonData);
    } else {
      throw Exception('Failed to load user profile');
    }
  }
}
