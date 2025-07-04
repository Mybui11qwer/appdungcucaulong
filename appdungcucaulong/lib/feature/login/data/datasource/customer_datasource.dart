import 'dart:convert';
import 'package:http/http.dart' as http;
import '../dto/customer_dto.dart';
import '../../../../core/network/api_constants.dart';

class CustomerDatasource {
  Future<List<CustomerDto>> authCustomerLogin() async {
    final response = await http.get(Uri.parse(ApiConstants.fetchAllCustomerLogin));

    if(response.statusCode == 200){
      final List jsonList = jsonDecode(response.body);
      return jsonList.map((json) => CustomerDto.fromJson(json)).toList();
    }
    else {
      throw Exception('Lỗi khi load dữ liệu khách hàng');
    }
  }
}