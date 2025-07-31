import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/network/api_constants.dart';
import '../../domain/entity/order_detail_entity.dart';
import '../../domain/entity/order_entity.dart';
import '../dto/order_dto.dart';

class OrderRemoteDatasource {
  final http.Client client;

  OrderRemoteDatasource({required this.client});

  Future<OrderEntity> createOrder({
    required int customerId,
    required List<Map<String, dynamic>> products,
    required double total,
    required String paymentMethod,
    required String shippingAddress,
    int? saleId,
  }) async {
    final response = await client.post(
      Uri.parse('${ApiConstants.baseUrl}/order'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'customerId': customerId,
        'products': products,
        'total': total,
        'paymentMethod': paymentMethod,
        'shippingAddress': shippingAddress,
        'saleId': saleId,
      }),
    );

    if (response.statusCode == 201) {
      final id = jsonDecode(response.body)['orderId'];
      return OrderEntity(
        id: id,
        customerId: customerId,
        total: total,
        status: 'Chờ xử lý',
        paymentMethod: paymentMethod,
        shippingAddress: shippingAddress,
        orderDate: DateTime.now(),
        saleId: saleId,
      );
    } else {
      throw Exception('Tạo đơn hàng thất bại');
    }
  }

  Future<List<OrderEntity>> getOrdersByCustomer(int customerId) async {
    final response = await client.get(
      Uri.parse('${ApiConstants.baseUrl}/order/customer/$customerId'),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => OrderDto.fromJson(e).toEntity()).toList();
    } else {
      throw Exception('Không thể lấy danh sách đơn hàng');
    }
  }

  Future<List<OrderItemEntity>> getOrderDetails(int orderId) async {
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/order/$orderId'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => OrderItemEntity.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load order details');
    }
  }

  Future<void> cancelOrder(int orderId) async {
    final response = await http.put(
      Uri.parse('${ApiConstants.baseUrl}/order/cancel/$orderId'),
    );

    if (response.statusCode != 200) {
      throw Exception('Hủy đơn hàng thất bại');
    }
  }
}
