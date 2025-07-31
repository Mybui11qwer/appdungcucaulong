// ignore_for_file: sort_child_properties_last

import 'package:appdungcucaulong/feature/order/presentation/bloc/bloc_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/network/api_constants.dart';
import '../../../product/domain/entity/product_entity.dart';
import '../../domain/di/order_injection.dart';
import '../../domain/entity/order_detail_entity.dart';
import '../../domain/entity/order_entity.dart';
import '../../domain/repository/order_repository.dart';
import '../bloc/bloc_event.dart';
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
                      "Ordered Date",
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
                        order.status == 'Canceled'
                            ? ElevatedButton(
                          onPressed: null, // disabled
                          child: const Text("Canceled"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow[700],
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                          ),
                        )
                            : ElevatedButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                              ),
                              isScrollControlled: true,
                              builder: (context) => _buildOrderDetailsBottomSheet(context, orderItems),
                            );
                          },
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
                            onPressed: () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Confirm'),
                                  content: const Text('Do you want to cancel this order?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, false),
                                      child: const Text('No'),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, true),
                                      child: const Text('Yes'),
                                    ),
                                  ],
                                ),
                              );

                              if (confirm != true) return;

                              try {
                                final response = await sl<OrderRepository>().cancelOrder(order.id);
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Your order has been canceled')),
                                  );

                                  final prefs = await SharedPreferences.getInstance();
                                  final customerId = prefs.getInt('customerId');
                                  if (customerId != null) {
                                    context.read<OrderHistoryBloc>().add(FetchOrderHistory(customerId));
                                  }
                                }
                              } catch (e) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Error while canceling this order')),
                                  );
                                }
                              }
                            },
                            child: const Text("Cancel"),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.red,
                              side: const BorderSide(color: Colors.red),
                            ),
                          )
                        else if (order.status == 'Processed')
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.green[600],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              "Processed",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
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
  Widget _buildOrderDetailsBottomSheet(BuildContext context, List<OrderItemEntity> items) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Order Details",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 300,
            child: ListView.separated(
              itemCount: items.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final item = items[index];
                final product = allProducts.firstWhere(
                      (p) => p.id == item.productId,
                  orElse: () => ProductEntity(
                    id: 0,
                    name: "Unknown",
                    price: 0,
                    quantity: 0,
                    description: "",
                    image: "lening.png",
                  ),
                );
                return ListTile(
                  leading: Image.network(
                    '${ApiConstants.baseUrl}/public/images/${product.image}',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(product.name),
                  subtitle: Text("Quantity: ${item.quantity}"),
                  trailing: Text("${item.unitPrice.toStringAsFixed(0)}\$"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
