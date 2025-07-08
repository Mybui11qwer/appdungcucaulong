import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/network/api_constants.dart';
import '../dto/request/add_to_cart_dto.dart';
import '../dto/respone/cart_item_response_dto.dart';

class CartRemoteDataSource {
  final http.Client client;

  CartRemoteDataSource({required this.client});

  Future<Map<String, String>> _buildHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Future<List<CartItemResponseDTO>> getCart() async {
    final headers = await _buildHeaders();
    final response = await client.get(
      Uri.parse(ApiConstants.getCart),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => CartItemResponseDTO.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch cart: ${response.body}');
    }
  }

  Future<void> addToCart(AddToCartDTO dto) async {
    final headers = await _buildHeaders();
    final response = await client.post(
      Uri.parse(ApiConstants.addToCart),
      headers: headers,
      body: jsonEncode(dto.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add to cart: ${response.body}');
    }
  }

  Future<void> removeFromCart(int cartItemId) async {
    final headers = await _buildHeaders();
    final response = await client.delete(
      Uri.parse(ApiConstants.removeFromCart),
      headers: headers,
      body: jsonEncode({'cartItemId': cartItemId}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to remove from cart: ${response.body}');
    }
  }
}
