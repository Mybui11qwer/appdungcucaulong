import 'package:appdungcucaulong/config/shared/widget/main_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_constants.dart';
import '../../../cart/presentation/page/cart_page.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_state.dart';
import 'product_detail_page.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ProductLoaded) {
                  return ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      _buildCategorySection(),
                      _buildBestSellerSection(state),
                    ],
                  );
                } else if (state is ProductError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ), currentIndex: 3,
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1A3C6B),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(32),
        ),
      ),
      padding: const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _circleIcon(Icons.search),
          const SizedBox(width: 24),
          GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CartPage()),
            );
          },
          child: _circleIcon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
    );
  }

  Widget _circleIcon(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Icon(icon, color: Color(0xFF1A3C6B)),
    );
  }

  Widget _buildCategorySection() {
    final categories = [
      Icons.checkroom,
      Icons.sports_handball,
      Icons.sports_tennis,
      Icons.sports_baseball,
      Icons.sports,
    ];
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Categories', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text('See all', style: TextStyle(color: Color(0xFF1A3C6B), fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 64,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                return Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6F0FA),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(categories[index], size: 36, color: Color(0xFF1A3C6B)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBestSellerSection(ProductLoaded state) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Best seller', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text('See all', style: TextStyle(color: Color(0xFF1A3C6B), fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              final product = state.products[index];
              return _buildProductCard(context ,product);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(BuildContext context ,product) {
    return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProductDetailPage(productId: product.id ,product: product),
        ),
      );
    },
    child: Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF6F8FB),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child:
                  Image.network('${ApiConstants.baseUrl}/public/images/${product.image}', fit: BoxFit.contain)
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${product.price} đ',
            style: const TextStyle(
              color: Color(0xFF1A3C6B),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            product.name,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.favorite_border, color: Color(0xFF1A3C6B), size: 20),
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)],
                ),
                child: const Icon(Icons.add, color: Color(0xFF1A3C6B), size: 20),
              ),
            ],
          ),
        ],
      ),
    ),
    );
  }
}