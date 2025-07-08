// ignore_for_file: unnecessary_string_interpolations

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../core/network/api_constants.dart';
import '../dto/product_dto.dart';

class ProductRemoteDatasource {
  final http.Client client;

  ProductRemoteDatasource({required this.client});

  Future<List<ProductDTO>> fetchProducts() async {
    final response = await client.get(Uri.parse('${ApiConstants.products}'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => ProductDTO.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<ProductDTO> getProductDetail(int id) async {
    final response = await http.get(Uri.parse(ApiConstants.productDetail(id)));
    final data = jsonDecode(response.body);
    return ProductDTO.fromJson(data);
  }
}
