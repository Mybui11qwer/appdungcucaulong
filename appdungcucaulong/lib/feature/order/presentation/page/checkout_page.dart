import 'package:flutter/material.dart';
import '../../../cart/domain/entity/cart_item_entity.dart';
import '../../../order/domain/usecase/create_order_usecase.dart';
import '../../../order/domain/entity/order_entity.dart';
import '../../../order/domain/di/order_injection.dart' show sl;

class CheckoutPage extends StatefulWidget {
  final List<CartItemEntity> cartItems;

  const CheckoutPage({super.key, required this.cartItems});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _addressController = TextEditingController();
  String _paymentMethod = 'Tiền mặt';

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
      final customerId = 1;
      final products = widget.cartItems
          .map((item) => {
        'productId': item.productId,
        'sizeId': item.sizeId,
        'quantity': item.quantity,
        'unitPrice': item.price,
      })
          .toList();

      final usecase = sl<CreateOrderUseCase>();

      final order = await usecase.call(
        customerId,
        products,
        total: total,
        paymentMethod: _paymentMethod,
        shippingAddress: _addressController.text,
      );

      Navigator.pop(context); // về lại sau khi đặt xong
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
      appBar: AppBar(title: Text("Thanh toán")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Sản phẩm", style: Theme.of(context).textTheme.titleMedium),
            ...widget.cartItems.map((item) => ListTile(
              title: Text(item.productName),
              subtitle: Text("SL: ${item.quantity} x ${item.price}"),
            )),
            Divider(),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(labelText: "Địa chỉ giao hàng"),
            ),
            DropdownButtonFormField<String>(
              value: _paymentMethod,
              items: ['Tiền mặt', 'Chuyển khoản']
                  .map((method) => DropdownMenuItem(
                value: method,
                child: Text(method),
              ))
                  .toList(),
              onChanged: (value) => setState(() => _paymentMethod = value!),
              decoration: InputDecoration(labelText: "Phương thức thanh toán"),
            ),
            const SizedBox(height: 16),
            Text("Tổng tiền: ${total.toStringAsFixed(0)} đ",
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _checkout,
                child: _isLoading
                    ? CircularProgressIndicator()
                    : Text("Đặt hàng"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
