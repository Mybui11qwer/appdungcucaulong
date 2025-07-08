import 'package:http/http.dart' as http;
import '../../data/datasource/product_remote_datasource.dart';
import '../../data/repository_impl/product_repository_impl.dart';
import '../../domain/usecase/get_all_products_usecase.dart';
import '../../presentation/bloc/product_bloc.dart';
import '../usecase/get_product_detail_usecase.dart';

ProductBloc injectProductBloc() {
  final client = http.Client();
  final datasource = ProductRemoteDatasource(client: client);
  final repository = ProductRepositoryImpl(remoteDatasource: datasource);
  final usecase1 = GetAllProductsUsecase(repository);
  final usecase2 = GetProductDetailUseCase(repository);
  return ProductBloc(getAllProducts: usecase1, getProductById: usecase2);
}
