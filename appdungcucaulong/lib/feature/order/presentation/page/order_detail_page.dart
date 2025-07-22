import 'package:flutter/material.dart';
import '../../../product/domain/entity/product_entity.dart';
import '../../domain/entity/order_entity.dart';
import '../../domain/entity/order_detail_entity.dart';
//import '../../domain/repository/order_repository.dart'; // hoặc nơi bạn định nghĩa gọi API

class OrderDetailPage extends StatefulWidget {
  final OrderEntity order;
  final List<ProductEntity> allProducts;

  const OrderDetailPage({super.key, required this.order, required this.allProducts});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  List<OrderItemEntity> items = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order Details')),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final product = widget.allProducts.firstWhere(
                  (p) => p.id == item.productId,
                  orElse: () => ProductEntity(
                    id: 0,
                    name: "Unknown",
                    price: 0,
                    quantity: 0,
                    description: "",
                    image: "",
                  ),
                );

                return ListTile(
                  leading: Image.network(
                    'https://yourdomain.com/public/images/${product.image}',
                    width: 50,
                    height: 50,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported),
                  ),
                  title: Text(product.name),
                  subtitle: Text("Số lượng: ${item.quantity}, Đơn giá: ${item.unitPrice.toStringAsFixed(0)}"),
                  trailing: Text("${(item.unitPrice * item.quantity).toStringAsFixed(0)}₫"),
                );
              },
            ),
    );
  }
}
