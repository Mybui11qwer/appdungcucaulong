import 'package:appdungcucaulong/components/custom-snackbar/index.dart';
import 'package:appdungcucaulong/feature/cart/data/dto/request/add_to_cart_dto.dart';
import 'package:appdungcucaulong/feature/cart/presentation/bloc/cart_bloc.dart';
import 'package:appdungcucaulong/feature/cart/presentation/bloc/cart_event.dart';
import 'package:appdungcucaulong/feature/product/controller/detail_add_to_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class AddToCartSection extends StatelessWidget {
  final int id;
  final double? price;
  const AddToCartSection({super.key, required this.id,required this.price});

  @override
  Widget build(BuildContext context) {
    final DetailAddToCartController _controller = Get.put(
      DetailAddToCartController(),
    );
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.blue[100], // nền
                shape: BoxShape.circle,  // hình tròn, hoặc dùng borderRadius cho bo góc vuông
              ),
              child: IconButton(
                onPressed: () {
                  _controller.minus();
                },
                icon: Icon(Icons.remove),
                color: Colors.blue,
              ),
            ),
            SizedBox(width: 10),
            Text(_controller.qtt.value.toString()),
            SizedBox(width: 10),
            Container(
               decoration: BoxDecoration(
                color: Colors.blue[100], // nền
                shape: BoxShape.circle,  // hình tròn, hoặc dùng borderRadius cho bo góc vuông
              ),
              child: IconButton(
                padding: EdgeInsets.all(1),
                onPressed: () {
                  _controller.add();
                },
                icon: Icon(Icons.add),
                color: Colors.white,
              ),
            ),
            SizedBox(width: 10,),
            SizedBox(
              width: screenWidth/2+ 20,
              child: ElevatedButton(
                onPressed: () {
                  final dto = AddToCartDTO(productId: id, sizeId: 1, quantity: 1);
                  context.read<CartBloc>().add(AddToCartEvent(dto));
                  CustomSnackbar.show(context, "Đã thêm vào giỏ hàng");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange, // màu nền
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // bo góc
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  elevation: 0, // không đổ bóng
                ),
                child: Text(
                  'Chọn · ${price!.round()}đ',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
