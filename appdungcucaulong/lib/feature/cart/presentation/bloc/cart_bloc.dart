import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repository/cart_repository.dart';
import '../../domain/usecase/get_cart_usecase.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartUseCase getCartUseCase;
  final CartRepository cartRepository;

  CartBloc({required this.cartRepository, required this.getCartUseCase}) : super(CartInitial()) {
    on<LoadCartEvent>((event, emit) async {
      emit(CartLoading());
      try {
        final items = await getCartUseCase();
        emit(CartLoaded(items));
      } catch (e) {
        emit(CartError(e.toString()));
      }
    });

    on<AddToCartEvent>((event, emit) async {
      try {
        await cartRepository.addToCart(event.dto);
        final items = await getCartUseCase();
        emit(CartLoaded(items));
      } catch (e) {
        emit(CartError('Thêm vào giỏ hàng thất bại'));
      }
    });

    on<RemoveFromCartEvent>((event, emit) async {
      emit(CartLoading());
      try {
        await cartRepository.removeFromCart(event.cartItemId);
        final items = await getCartUseCase();
        emit(CartLoaded(items));
      } catch (e) {
        emit(CartError("Xoá sản phẩm thất bại"));
      }
    });

    on<UpdateQuantityEvent>((event, emit) async {
      try {
        // Gọi service để update quantity (tuỳ vào cách bạn lưu cart)
        await cartRepository.updateQuantity(event.productId, event.quantity);
        final items = await cartRepository.getCart();
        emit(CartLoaded(items));
      } catch (e) {
        emit(CartError("Lỗi khi cập nhật số lượng"));
      }
    });
  }
}
