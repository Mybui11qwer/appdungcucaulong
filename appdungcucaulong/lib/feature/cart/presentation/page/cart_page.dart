import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/network/api_constants.dart';
import '../../../auth/domain/di/auth_injection.dart';
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
        backgroundColor: Color(0xFF0B3D91), // Deep Blue
        body: SafeArea(
          child: BlocBuilder<CartBloc, CartState>(
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
                        padding: EdgeInsets.all(16),
                        itemCount: state.items.length,
                        itemBuilder: (_, index) {
                          final item = state.items[index];
                          return Container(
                            margin: EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(color: Colors.black12, blurRadius: 4),
                              ],
                            ),
                            child: Stack(
                              children: [
                                // Decorative Circles
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.lightBlue[100],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 8,
                                  right: 8,
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blue[800],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          '${ApiConstants.baseUrl}/public/images/${item.image}',
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.productName,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text("Yonex", style: TextStyle(color: Colors.grey[600])),
                                            SizedBox(height: 4),
                                            Text(
                                              "${item.price.toStringAsFixed(0)} \$",
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.remove_circle, color: Colors.blue),
                                            onPressed: () {
                                              if (item.quantity > 1) {
                                                context.read<CartBloc>().add(
                                                    UpdateQuantityEvent(item.id, item.quantity - 1));
                                              }
                                            },
                                          ),
                                          Text(
                                            "${item.quantity}",
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.add_circle, color: Colors.blue),
                                            onPressed: () {
                                              context.read<CartBloc>().add(
                                                  UpdateQuantityEvent(item.id, item.quantity + 1));
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                        boxShadow: [
                          BoxShadow(color: Colors.black26, blurRadius: 6),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total: ${totalPrice.toStringAsFixed(0)} \$",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                            icon: Icon(Icons.check_circle_outline),
                            label: Text("Checkout"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF004AAD),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
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
      ),
    );
  }
}
