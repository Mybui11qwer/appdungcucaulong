import 'package:get/get.dart';

class DetailAddToCartController extends GetxController {
  RxInt qtt = 1.obs;

  void add() {
    qtt.value++;
  }

  void minus() {
    if (qtt.value > 1) {
      qtt.value--;
    }
  }
}
