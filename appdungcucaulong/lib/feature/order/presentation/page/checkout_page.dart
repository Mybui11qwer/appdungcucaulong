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
      backgroundColor: const Color(0xFFf4efef),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: const Color(0xFF0e3e8a),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Checkout Order",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.arrow_back_ios_new, size: 16),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            ...widget.cartItems.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                        child: Image.network(
                          '${ApiConstants.baseUrl}/public/images/${item.image}',
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.productName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0e3e8a),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text("${item.price.toStringAsFixed(0)}\$"),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF0e3e8a),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                        child: Text(
                          item.quantity.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Text(
                        "ORDER FORM",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0e3e8a),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildInputField("Name", _nameController),
                      const SizedBox(height: 8),
                      _buildInputField("Location", _addressController),
                      const SizedBox(height: 8),
                      _buildInputField("Note", _noteController),
                      const SizedBox(height: 8),
                      Column(
                        children: [
                          RadioListTile<String>(
                            title: const Text("Momo"),
                            value: "Momo",
                            groupValue: _paymentMethod,
                            onChanged: (value) {
                              setState(() => _paymentMethod = value!);
                            },
                          ),
                          RadioListTile<String>(
                            title: const Text("COD"),
                            value: "COD",
                            groupValue: _paymentMethod,
                            onChanged: (value) {
                              setState(() => _paymentMethod = value!);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Money: ${total.toStringAsFixed(0)} \$"),
                          Text("Total Products: ${widget.cartItems.length}"),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0e3e8a),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: _isLoading ? null : _checkout,
                          child: _isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text("CHECKOUT", style: TextStyle(color: Colors.white)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}
