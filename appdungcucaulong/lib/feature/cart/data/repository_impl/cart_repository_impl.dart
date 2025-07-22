import '../../domain/entity/cart_item_entity.dart';
import '../../domain/repository/cart_repository.dart';
import '../dto/request/add_to_cart_dto.dart';
import '../mapper/cart_mapper.dart';
import '../datasource/cart_remote_datasource.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remoteDataSource;

  CartRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> addToCart(AddToCartDTO dto) async {
    await remoteDataSource.addToCart(dto);
  }

  @override
  Future<List<CartItemEntity>> getCart() async {
    final dtoList = await remoteDataSource.getCart();
    return dtoList.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> removeFromCart(int cartItemId) async {
    await remoteDataSource.removeFromCart(cartItemId);
  }
  
  @override
  Future<void> updateQuantity(int cartItemId, int quantity) {
    return remoteDataSource.updateQuantity(cartItemId, quantity);
  }
}
