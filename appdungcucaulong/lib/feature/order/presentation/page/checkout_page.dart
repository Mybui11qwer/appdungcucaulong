import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/network/api_constants.dart';
import '../../../cart/domain/entity/cart_item_entity.dart';
import '../../../order/domain/usecase/create_order_usecase.dart';
import '../../../order/domain/di/order_injection.dart' show sl;

class CheckoutPage extends StatefulWidget {
  final List<CartItemEntity> cartItems;

  const CheckoutPage({super.key, required this.cartItems});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _noteController = TextEditingController();
  String _paymentMethod = 'Momo';

  bool _isLoading = false;

  double get total => widget.cartItems.fold(
        0,
        (sum, item) => sum + (item.price * item.quantity),
      );

  void _checkout() async {
    if (_addressController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Vui lòng nhập địa chỉ giao hàng")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final prefs = await SharedPreferences.getInstance();
      final customerId = prefs.getInt('customerId');

      if (customerId == null || customerId == 0) {
        throw Exception("Không tìm thấy tài khoản khách hàng");
      }

      final products = widget.cartItems.map((item) {
        return {
          'productId': item.productId,
          'sizeId': item.sizeId,
          'quantity': item.quantity,
          'unitPrice': item.price,
        };
      }).toList();

      final usecase = sl<CreateOrderUseCase>();

      final order = await usecase.call(
        customerId,
        products,
        total: total,
        paymentMethod: _paymentMethod,
        shippingAddress: _addressController.text,
      );

      if (!mounted) return;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("✅ Đặt hàng thành công (ID: ${order.id})")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Đặt hàng thất bại: $e")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF103F91),
      body: Stack(
        children: [
          // Header (trên cùng)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 160,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.arrow_back, color: Colors.white),
                    Text(
                      'Thông tin thanh toán',
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 24), // placeholder để giữ cân đối
                  ],
                ),
              ),
            ),
          ),
          // Nội dung
          Positioned(
            top: 160,
            left: 0,
            right: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 160,
              decoration: BoxDecoration(
                color: Color(0xffeae5e5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Phần trắng chứa ảnh + tên + giá
                          Container(
                            width: MediaQuery.of(context).size.width - 100, // trừ phần số lượng
                            height: 80,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                // Ảnh
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    '${ApiConstants.baseUrl}/public/images/lening.png',
                                    width: 45,
                                    height: 45,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                // Tên + giá
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Lining AS10 3230',
                                      style: TextStyle(
                                        color: Color(0xFF103F91),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      '32\$',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          // Phần xanh chứa số lượng
                          Container(
                            width: 50,
                            height: 80,
                            decoration: const BoxDecoration(
                              color: Color(0xFF103F91),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              '1',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ),

                  //TEXT Order

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFF0e3e8a),
        hintStyle: const TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}
