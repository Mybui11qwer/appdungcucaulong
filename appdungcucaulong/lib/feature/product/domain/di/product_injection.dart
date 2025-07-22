import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../../data/datasource/product_remote_datasource.dart';
import '../../data/repository_impl/product_repository_impl.dart';
import '../../domain/usecase/get_all_products_usecase.dart';
import '../../domain/usecase/get_product_detail_usecase.dart';
import '../../presentation/bloc/product_bloc.dart';

final getIt = GetIt.instance;

void initProductInjection() {
  final client = http.Client();
  final datasource = ProductRemoteDatasource(client: client);
  final repository = ProductRepositoryImpl(remoteDatasource: datasource);
  final usecase1 = GetAllProductsUsecase(repository);
  final usecase2 = GetProductDetailUseCase(repository);

  getIt.registerFactory<ProductBloc>(
    () => ProductBloc(
      getAllProducts: usecase1,
      getProductById: usecase2,
    ),
  );

  getIt.registerLazySingleton<GetAllProductsUsecase>(() => usecase1);
  getIt.registerLazySingleton<GetProductDetailUseCase>(() => usecase2);
}
