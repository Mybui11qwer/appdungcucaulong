import 'package:appdungcucaulong/components/custom-title/index.dart';
import 'package:appdungcucaulong/components/parallel-widget/index.dart';
import 'package:appdungcucaulong/feature/product/domain/entity/product_entity.dart';
import 'package:flutter/material.dart';

class ProductContent extends StatelessWidget {
  final ProductEntity product;
  
  const ProductContent({super.key,required this.product});

  @override
  Widget build(BuildContext context) {
    return  Container(
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           SizedBox(height: 16),
            ParallelWidget(
              widget1: CustomTitle(
              text: product.name,
              txtSize: 26,
              fontWeight: FontWeight.w500,
              MaxLine: 2,
            ), 
            widget2: Icon(Icons.favorite_outline)
            ),
           
            const SizedBox(height: 8),
            Text(
              "${product.price.toStringAsFixed(0)} đ",
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Text(
              product.description.isNotEmpty ? product.description : "Không có mô tả.",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 80),
        ],
      ),
    );
  }
}