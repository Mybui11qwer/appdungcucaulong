import 'package:appdungcucaulong/config/shared/widget/main_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cart/data/dto/request/add_to_cart_dto.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../cart/presentation/bloc/cart_event.dart';
import '../../domain/entity/product_entity.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductEntity product;
  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      currentIndex: 0,
      body: Column(
        children: [
          SafeArea(
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context); 
                  },
                ),
                const Expanded(
                  child: Text(
                    "Chi tiết sản phẩm",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 48), 
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    product.image,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    product.name,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${product.price.toStringAsFixed(0)} đ",
                    style: const TextStyle(fontSize: 18, color: Colors.blue),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    product.description.isNotEmpty ? product.description : "Không có mô tả.",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: ElevatedButton.icon(
              onPressed: () {
                final dto = AddToCartDTO(
                  productId: product.id,
                  sizeId: 1, // 👈 TODO: sau này thay bằng dropdown chọn size
                  quantity: 1,
                );

                context.read<CartBloc>().add(AddToCartEvent(dto));

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Đã thêm vào giỏ hàng")),
                );
              },
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text("Thêm vào giỏ hàng"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
