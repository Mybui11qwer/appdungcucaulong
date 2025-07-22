// ignore_for_file: sort_child_properties_last

import 'package:appdungcucaulong/feature/order/presentation/bloc/bloc_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_constants.dart';
import '../../../product/domain/entity/product_entity.dart';
import '../../domain/di/order_injection.dart';
import '../../domain/entity/order_detail_entity.dart';
import '../../domain/entity/order_entity.dart';
import '../../domain/repository/order_repository.dart';
import '../bloc/checkout_bloc.dart';

class OrderHistoryPage extends StatelessWidget {
  final List<ProductEntity> allProducts;

  const OrderHistoryPage({super.key, required this.allProducts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF144AAC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF144AAC),
        title: const Text(
          'Order History',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Color(0xFFF3F1F6),
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
          builder: (context, state) {
            if (state is OrderHistoryLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is OrderHistoryLoaded) {
              return ListView.builder(
                itemCount: state.orders.length,
                itemBuilder: (context, index) {
                  final order = state.orders[index];
                  return _buildOrderCard(context, order);
                },
              );
            } else if (state is OrderHistoryError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildOrderCard(BuildContext context,OrderEntity order) {
    return FutureBuilder<List<OrderItemEntity>>(
      future: sl<OrderRepository>().getOrderDetails(order.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text("No product info");
        }

        final orderItems = snapshot.data!;
        final firstItem = orderItems.first;

        final product = allProducts.firstWhere(
          (p) => p.id == firstItem.productId,
          orElse:
              () => ProductEntity(
                id: 0,
                name: "Unknown",
                price: 0,
                quantity: 0,
                description: "",
                image: "lening.png",
              ),
        );

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                '${ApiConstants.baseUrl}/public/images/${product.image}',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ngày đặt",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      "${product.name}\n${order.total.toStringAsFixed(0)}\$",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(order.shippingAddress),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text("Details"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFF004AAD),
                            side: const BorderSide(color: Color(0xFF004AAD)),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (order.status == 'Processing')
                          OutlinedButton(
                            onPressed: () {},
                            child: const Text("Cancel"),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.red,
                              side: const BorderSide(color: Colors.red),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              CircleAvatar(
                backgroundColor:
                    order.status == 'Success' ? Colors.green : Colors.blue,
                child: Icon(
                  order.status == 'Success'
                      ? Icons.check
                      : Icons.local_shipping,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
