import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/network/api_constants.dart';
import '../../../cart/data/dto/request/add_to_cart_dto.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../cart/presentation/bloc/cart_event.dart';
import '../../domain/entity/product_entity.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductEntity product;
  final int productId;

  const ProductDetailPage({super.key, required this.product, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                color: Colors.blue[900], // nền xanh đậm phía trên
                height: 250,
                width: double.infinity,
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const Expanded(
                        child: Text(
                          "Chi tiết sản phẩm",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 60,
                left: 0,
                right: 0,
                child: Center(
                  child: Image.network(
                    '${ApiConstants.baseUrl}/public/images/${product.image}',
                    height: 200,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 80, color: Colors.white),
                  ),
                ),
              ),
              Positioned(
                top: 240,
                left: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[300],
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(text: "Material: ", style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: "Plastic"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(text: "Variant: ", style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: "Black, White, Orange"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(text: "Description: ", style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: "Black, White, Orange"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 80), // khoảng trống sau phần card
          // Phần danh sách sản phẩm liên quan
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Container(
                height: 100,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('${ApiConstants.baseUrl}/public/images/sample_racket_bg.jpg'), // background ví dụ
                    fit: BoxFit.cover,
                    // ignore: deprecated_member_use
                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      color: Colors.white,
                      child: Center(
                        child: Image.network(
                          'https://upload.wikimedia.org/wikipedia/commons/7/73/Yonex_logo.svg',
                          fit: BoxFit.contain,
                          width: 48,
                          height: 48,
                          errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Yonex",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Hcm, VN",
                            style: TextStyle(color: Colors.white70),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            children: [
                              _buildTag("Racket"),
                              _buildTag("Gear"),
                              _buildTag("Racket"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.favorite_border, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Spacer(),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildBottomNavIcon(
                  Icons.info,
                  false,
                  onTap: () {
                  },
                ),
                _buildBottomNavIcon(
                  Icons.favorite,
                  true,
                  onTap: () {
                  },
                ),
                _buildBottomNavIcon(
                  Icons.share,
                  false,
                  onTap: () {
                  },
                ),
                _buildBottomNavIcon(
                  Icons.shopping_bag_outlined,
                  false,
                  onTap: () {
                  },
                ),
                _buildBottomNavIcon(
                  Icons.shopping_cart,
                  false,
                  onTap: () {
                    final dto = AddToCartDTO(
                      productId: product.id,
                      sizeId: 1,
                      quantity: 1,
                    );

                    context.read<CartBloc>().add(AddToCartEvent(dto));

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Đã thêm vào giỏ hàng")),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white54,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: const TextStyle(color: Colors.black)),
    );
  }

  Widget _buildBottomNavIcon(
    IconData icon,
    bool active, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: active ? Colors.purple[300] : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: active ? Colors.white : Colors.black54),
      ),
    );
  }
}
