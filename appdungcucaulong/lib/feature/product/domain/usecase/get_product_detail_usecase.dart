import '../entity/product_entity.dart';
import '../repository/product_repository.dart';

class GetProductDetailUseCase {
  final ProductRepository repository;

  GetProductDetailUseCase(this.repository);

  Future<ProductEntity> call(int id) {
    return repository.getProductDetail(id);
  }
}
