import '../../domain/entity/product_entity.dart';
import '../../domain/repository/product_repository.dart';
import '../datasource/product_remote_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDatasource remoteDatasource;

  ProductRepositoryImpl({required this.remoteDatasource});

  @override
  Future<List<ProductEntity>> getAllProducts() async {
    final dtos = await remoteDatasource.fetchProducts();
    return dtos.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<ProductEntity> getProductDetail(int id) async {
    final dto = await remoteDatasource.getProductDetail(id);
    return dto.toEntity();
  }
}
