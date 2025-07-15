// lib/feature/profile/domain/di/profile_di.dart
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../../data/datasource/profile_remote_datasource.dart';
import '../../data/repository_impl/profile_repository_impl.dart';
import '../../domain/usecase/get_user_profile_usecase.dart';
import '../../domain/repository/profile_repository.dart';
import '../../presentation/bloc/profile_bloc.dart';

final sl = GetIt.instance;

void initProfileModule() {
  // Datasource
  sl.registerLazySingleton(() => ProfileRemoteDatasource(client: http.Client()));

  // Repository
  sl.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(remote: sl()));

  // UseCase
  sl.registerLazySingleton(() => GetUserProfileUseCase(sl()));

  // Bloc
  sl.registerFactory(() => ProfileBloc(sl()));
}
