import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/get_product_detail_usecase.dart';
import 'product_event.dart';
import 'product_state.dart';
import '../../domain/usecase/get_all_products_usecase.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetAllProductsUsecase getAllProducts;
  final GetProductDetailUseCase getProductById;

  ProductBloc({required this.getAllProducts, required this.getProductById})
    : super(ProductInitial()) {
    on<LoadProductsEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await getAllProducts();
        emit(ProductLoaded(products));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    on<GetProductDetailEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        // Giả sử bạn có 1 usecase getProductById
        final product = await getProductById(event.id);
        emit(ProductDetailLoaded(product));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
  }
}
