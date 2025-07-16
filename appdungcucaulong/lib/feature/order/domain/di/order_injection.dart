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
  if (!sl.isRegistered<OrderRemoteDatasource>()) {
    sl.registerLazySingleton(() => http.Client());

    sl.registerLazySingleton<OrderRemoteDatasource>(
          () => OrderRemoteDatasource(client: sl()),
    );

    sl.registerLazySingleton<OrderRepository>(
          () => OrderRepositoryImpl(remoteDatasource: sl()),
    );

    sl.registerLazySingleton(() => CreateOrderUseCase(sl()));
    sl.registerLazySingleton(() => GetOrdersByCustomerUseCase(sl()));
    sl.registerLazySingleton(() => GetOrderDetailUseCase(sl()));
  }
}
