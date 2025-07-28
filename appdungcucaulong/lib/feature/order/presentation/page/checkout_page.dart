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

      final products =
          widget.cartItems.map((item) {
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("❌ Đặt hàng thất bại: $e")));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF103F91),
      body: SafeArea(
        child: Column(
          children: [
            // Header: Arrow back + Tiêu đề
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12,
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Xác nhận đơn hàng',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Danh sách sản phẩm
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children:[
                    ...widget.cartItems.map((item) => _buildCartItem(item, context)).toList(),

                    const SizedBox(height: 20),

                    // 📋 ORDER FORM
                    Container(
                      margin: const EdgeInsets.only(top: 24, bottom: 24),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              'ORDER FORM',
                              style: TextStyle(
                                color: Color(0xFF103F91),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildInputField("Tên người nhận", _nameController),
                          const SizedBox(height: 12),
                          _buildInputField("Địa chỉ giao hàng", _addressController),
                          const SizedBox(height: 12),
                          _buildInputField("Ghi chú", _noteController),
                          const SizedBox(height: 16),

                          // Phương thức thanh toán
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Radio<String>(
                                      value: 'Momo',
                                      groupValue: _paymentMethod,
                                      onChanged: (value) {
                                        setState(() {
                                          _paymentMethod = value!;
                                        });
                                      },
                                    ),
                                    const Text('Momo'),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Radio<String>(
                                      value: 'COD',
                                      groupValue: _paymentMethod,
                                      onChanged: (value) {
                                        setState(() {
                                          _paymentMethod = value!;
                                        });
                                      },
                                    ),
                                    const Text('COD'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // Tổng tiền & sản phẩm
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Tổng tiền: \$${total.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'Sản phẩm: ${widget.cartItems.length}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Nút CHECKOUT
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _checkout,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF103F91),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: _isLoading
                                  ? const CircularProgressIndicator(color: Colors.white)
                                  : const Text(
                                'CHECKOUT',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ]
                ),
              ),
            ),
          ],
        ),
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}

Widget _buildCartItem(CartItemEntity item, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16.0),
    child: Row(
      children: [
        // thông tin sản phẩm
        Container(
          width: MediaQuery.of(context).size.width - 100,
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
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  '${ApiConstants.baseUrl}/public/images/${item.image}',
                  width: 45,
                  height: 45,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.productName,
                    style: const TextStyle(
                      color: Color(0xFF103F91),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${item.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // số lượng
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
          child: Text(
            item.quantity.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ],
    ),
  );
}

