import 'package:get_it/get_it.dart';
import '../../data/datasource/auth_remote_datasource.dart';
import '../../data/datasource/auth_remote_datasource_impl.dart';
import '../../data/repository_impl/customer_repository_impl.dart';
import '../../presentation/bloc/login_bloc.dart';
import '../../presentation/bloc/register_bloc.dart';
import '../repository/customer_repository.dart';
import '../usecase/login_usecase.dart';
import '../usecase/register_usecase.dart';

final sl = GetIt.instance;

void initAuthInjection() {
  // Chia sẻ chung cho cả login và register
  sl.registerLazySingleton<AuthRemoteDatasource>(() => AuthRemoteDatasourceImpl());

  // Repository
  sl.registerLazySingleton<CustomerRepository>(() => CustomerRepositoryImpl(sl()));

  // Usecase
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));

  // Bloc
  sl.registerFactory(() => LoginBloc(sl()));
  sl.registerFactory(() => RegisterBloc(sl()));
}
