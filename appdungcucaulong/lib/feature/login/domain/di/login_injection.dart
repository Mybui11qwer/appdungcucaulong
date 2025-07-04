import 'package:get_it/get_it.dart';
import '../../data/datasource/login_remote_datasource.dart';
import '../../data/repository_impl/login_repository_impl.dart';
import '../../presentation/bloc/login_bloc.dart';
import '../repository/customer_repository.dart';
import '../usecase/get_customer_usecase.dart';

final sl = GetIt.instance;

void initLoginFeature() {
  // Bloc
  sl.registerFactory(() => LoginBloc(sl()));

  // Usecase
  sl.registerLazySingleton(() => LoginUseCase(sl()));

  // Repository
  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(sl()));

  // Datasource
  sl.registerLazySingleton(() => LoginRemoteDatasource());
}