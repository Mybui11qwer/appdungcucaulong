
import 'package:appdungcucaulong/feature/product/presentation/components/add_to_cart_section.dart';
import 'package:appdungcucaulong/feature/product/presentation/components/product_content.dart';
import 'package:flutter/material.dart';
import '../../../../core/network/api_constants.dart';
import '../../domain/entity/product_entity.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductEntity product;
  const ProductDetailPage({super.key, required this.product, required int productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Positioned(
                        child: SizedBox(
                          height: 300,
                          child: Image.network(
                            '${ApiConstants.baseUrl}/public/images/${product.image}',
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.fill,
                            errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
                          ),
                        ),),
                      Positioned(
                        top: 0,
                        left: 10,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            width: 40,
                            height: 40,
                            padding: const EdgeInsets.only(left: 4),
                            color: Colors.blueGrey,
                            child: IconButton(onPressed: (){
                               Navigator.pop(context);
                            }, icon: Icon(Icons.arrow_back_ios, color: Colors.white,)),
                          ),
                        ))
                    ],
                  ),
                  const SizedBox(height: 16),
                  ProductContent(product: product)
                ],
              ),
            ),
          ),
          AddToCartSection(id: product.id, price:  product.price, )
        ],
      ),
    );
  }
}
