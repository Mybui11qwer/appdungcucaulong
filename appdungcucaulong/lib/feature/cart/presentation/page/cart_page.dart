import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_constants.dart';
import '../../../auth/domain/di/auth_injection.dart' show sl;
import '../../../order/presentation/page/checkout_page.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';
import '../bloc/cart_state.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CartBloc>()..add(LoadCartEvent()),
      child: Scaffold(
        appBar: AppBar(title: Text("Giỏ hàng")),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) return Center(child: CircularProgressIndicator());
            if (state is CartError) return Center(child: Text("❌ ${state.message}"));
            if (state is CartLoaded) {
              if (state.items.isEmpty) return Center(child: Text("🛒 Giỏ hàng trống"));

              final totalPrice = state.items.fold<double>(
                0,
                    (sum, item) => sum + (item.price * item.quantity),
              );

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.items.length,
                      itemBuilder: (_, index) {
                        final item = state.items[index];
                        return ListTile(
                          leading: Image.network(
                            '${ApiConstants.baseUrl}/public/images/${item.image}',
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(item.productName),
                          subtitle: Text("${item.price} đ x ${item.quantity}"),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: Text("Xác nhận"),
                                  content: Text("Bạn có chắc muốn xoá sản phẩm này khỏi giỏ hàng?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, false),
                                      child: Text("Huỷ"),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, true),
                                      child: Text("Xoá"),
                                    ),
                                  ],
                                ),
                              );

                              if (confirm == true) {
                                context.read<CartBloc>().add(RemoveFromCartEvent(item.id));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("🗑 Đã xóa sản phẩm")),
                                );
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tổng: ${totalPrice.toStringAsFixed(0)} đ",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CheckoutPage(cartItems: state.items),
                              ),
                            );
                          },
                          icon: Icon(Icons.shopping_cart_checkout),
                          label: Text("Thanh toán"),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            backgroundColor: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

