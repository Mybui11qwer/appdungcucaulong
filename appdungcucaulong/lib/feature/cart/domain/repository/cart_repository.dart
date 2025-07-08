import '../entity/cart_item_entity.dart';
import '../../data/dto/request/add_to_cart_dto.dart';

abstract class CartRepository {
  Future<List<CartItemEntity>> getCart();
  Future<void> addToCart(AddToCartDTO dto);
  Future<void> removeFromCart(int cartItemId);
}
