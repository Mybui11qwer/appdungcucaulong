import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../order/presentation/page/checkout_page.dart';
import '../../../../core/network/api_constants.dart';
import '../../../auth/domain/di/auth_injection.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';
import '../bloc/cart_state.dart';

void showCartTopSheet(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Cart',
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (_, __, ___) => const SizedBox.shrink(),
    transitionBuilder: (_, animation, __, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, -1),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
        child: Align(
          alignment: Alignment.topCenter,
          child: Material(
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
            color: Colors.white,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              width: double.infinity,
              child: BlocProvider.value(
                value: sl<CartBloc>()..add(LoadCartEvent()),
                child: _CartPanel(),
              ),
            ),
          ),
        ),
      );
    },
  );
}

class _CartPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF0B3D91), // Nền xanh phía sau giống giao diện chính
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) return Center(child: CircularProgressIndicator());
          if (state is CartError) return Center(child: Text('❌ ${state.message}'));
          if (state is CartLoaded) {
            if (state.items.isEmpty) return Center(child: Text('🛒 Giỏ hàng trống'));

            final total = state.items.fold<double>(
              0,
              (sum, item) => sum + (item.price * item.quantity),
            );

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: state.items.length,
                    itemBuilder: (_, i) {
                      final item = state.items[i];
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
                            // Decorative circles (giống giao diện chính)
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
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 4),
                                        Text("Yonex", style: TextStyle(color: Colors.grey[600])),
                                        SizedBox(height: 4),
                                        Text("${item.price.toStringAsFixed(0)} \$"),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.remove_circle, color: Colors.blue),
                                        onPressed: () {
                                          if (item.quantity > 1) {
                                            context.read<CartBloc>().add(UpdateQuantityEvent(item.productId, item.quantity - 1));
                                          }
                                        },
                                      ),
                                      Text("${item.quantity}", style: TextStyle(fontWeight: FontWeight.bold)),
                                      IconButton(
                                        icon: Icon(Icons.add_circle, color: Colors.blue),
                                        onPressed: () {
                                          context.read<CartBloc>().add(UpdateQuantityEvent(item.productId, item.quantity + 1));
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total: ${total.toStringAsFixed(0)} \$",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ElevatedButton.icon(
                        icon: Icon(Icons.check),
                        label: Text("Checkout"),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CheckoutPage(cartItems: state.items),
                            ),
                          );
                        },
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
                )
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

