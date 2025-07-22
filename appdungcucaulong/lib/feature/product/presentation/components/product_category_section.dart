
import 'package:appdungcucaulong/components/custom-sliver-grid/index.dart';
import 'package:appdungcucaulong/components/parralel-text/index.dart';
import 'package:appdungcucaulong/feature/product/presentation/bloc/product_bloc.dart';
import 'package:appdungcucaulong/feature/product/presentation/bloc/product_state.dart';
import 'package:appdungcucaulong/feature/product/presentation/components/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCategorySectionBloc extends StatelessWidget {
  final String? category;
  
  const ProductCategorySectionBloc({super.key, this.category,});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth - 20,
      child: Column(
        children: [
          ParrallelText(text1: 'Top ${category}', text2: 'View All'),
          SizedBox(height: 10,),
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ProductLoaded) {
                final products = state.products.sublist(0, 4);
                return CustomSilverGrid(
                  gridHeight: 630,
                  quantity: products.length,
                  aspectRatio: 0.62,
                  itemBuilder: (context, index) {
                    return ProductCardVer3(product: products[index]);
                  },
                );
              } else if (state is ProductError) {
                return Center(child: Text("Lỗi: ${state.message}"));
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}


