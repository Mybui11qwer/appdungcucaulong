import '../entity/cart_item_entity.dart';
import '../repository/cart_repository.dart';

class GetCartUseCase {
  final CartRepository repo;

  GetCartUseCase(this.repo);

  Future<List<CartItemEntity>> call() {
    return repo.getCart();
  }
}
