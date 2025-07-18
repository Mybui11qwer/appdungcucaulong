import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../../data/datasource/order_remote_datasource.dart';
import '../../data/repository_impl/order_repository_impl.dart';
import '../../domain/repository/order_repository.dart';
import '../../domain/usecase/create_order_usecase.dart';
import '../../domain/usecase/get_orders_by_customer_usecase.dart';
import '../../domain/usecase/get_order_detail_usecase.dart';

final sl = GetIt.instance;

void initOrderModule() {
  if (!sl.isRegistered<http.Client>()) {
    sl.registerLazySingleton(() => http.Client());
  }

  if (!sl.isRegistered<OrderRemoteDatasource>()) {
    sl.registerLazySingleton<OrderRemoteDatasource>(
      () => OrderRemoteDatasource(client: sl()),
    );
  }

  if (!sl.isRegistered<OrderRepository>()) {
    sl.registerLazySingleton<OrderRepository>(
      () => OrderRepositoryImpl(remoteDatasource: sl()),
    );
  }

  if (!sl.isRegistered<CreateOrderUseCase>()) {
    sl.registerLazySingleton(() => CreateOrderUseCase(sl()));
  }

  if (!sl.isRegistered<GetOrdersByCustomerUseCase>()) {
    sl.registerLazySingleton(() => GetOrdersByCustomerUseCase(sl()));
  }

  if (!sl.isRegistered<GetOrderDetailUseCase>()) {
    sl.registerLazySingleton(() => GetOrderDetailUseCase(sl()));
  }
}
