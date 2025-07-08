import '../entity/product_entity.dart';
import '../repository/product_repository.dart';

class GetAllProductsUsecase {
  final ProductRepository repository;

  GetAllProductsUsecase(this.repository);

  Future<List<ProductEntity>> call() {
    return repository.getAllProducts();
  }
}
