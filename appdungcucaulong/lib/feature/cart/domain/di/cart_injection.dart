import 'package:http/http.dart' as http;

import '../../../auth/domain/di/auth_injection.dart';
import '../../data/datasource/cart_remote_datasource.dart';
import '../../data/repository_impl/cart_repository_impl.dart';
import '../../presentation/bloc/cart_bloc.dart';
import '../repository/cart_repository.dart';
import '../usecase/get_cart_usecase.dart';

void initCartInjection() {
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => CartRemoteDataSource(client: sl()));
  sl.registerLazySingleton<CartRepository>(() => CartRepositoryImpl(sl()));

  sl.registerLazySingleton(() => GetCartUseCase(sl()));
  sl.registerFactory(() => CartBloc(
    getCartUseCase: sl(),
    cartRepository: sl(),
    ));
}
