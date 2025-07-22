import 'package:appdungcucaulong/components/custom-snackbar/index.dart';
import 'package:appdungcucaulong/components/custom-title/index.dart';
import 'package:appdungcucaulong/components/parallel-widget/index.dart';
import 'package:appdungcucaulong/const/styled.dart';
import 'package:appdungcucaulong/core/network/api_constants.dart';
import 'package:appdungcucaulong/feature/cart/data/dto/request/add_to_cart_dto.dart';
import 'package:appdungcucaulong/feature/cart/presentation/bloc/cart_bloc.dart';
import 'package:appdungcucaulong/feature/cart/presentation/bloc/cart_event.dart';
import 'package:appdungcucaulong/feature/product/domain/entity/product_entity.dart';
import 'package:appdungcucaulong/feature/product/presentation/page/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCardVer3 extends StatelessWidget {
  final ProductEntity product;

  const ProductCardVer3({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) =>
                    ProductDetailPage(productId: product.id, product: product),
          ),
        );
      },
      child: ClipRRect(
        // xài clipRect để cái border radius nó tròn đẹp hơn
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(color: Colors.blueGrey[50]),
          width: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Image.network(
                        '${ApiConstants.baseUrl}/public/images/${product.image}',
                        height: 100,
                        width: 100,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 10,
                      child: Icon(Icons.beenhere_sharp, color: Colors.orange),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              ParallelWidget(
                widget1: CustomTitle(
                  text: "${product.price.round().toString()} đ",
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  txtSize: 18,
                ),
                widget2: Icon(
                  Icons.favorite_border,
                  weight: 200,
                  size: 22,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 10),
              CustomTitle(
                text: product.name,
                textStyle: TextStyled.s4,
                MaxLine: 1,
              ),
              SizedBox(height: 25),
              ParallelWidget(
                widget1: CustomTitle(
                  text: "Vợt cầu lông",
                  txtSize: 14,
                  color: TextStyled.subCL,
                ),
                widget2: GestureDetector(
                  onTap: () {
                    final dto = AddToCartDTO(
                      productId: product.id,
                      sizeId: 1,
                      quantity: 1,
                    );

                    context.read<CartBloc>().add(AddToCartEvent(dto));

                    CustomSnackbar.show(context, 'Đã thêm vào giỏ hàng');
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Icon(Icons.add, color: Colors.white, size: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
