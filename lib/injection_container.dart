import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:dio/dio.dart';
import 'core/network/api_service.dart';
import 'core/network/network_info.dart';
import 'feature/home/data/datasource/home_remote_data_source.dart';
import 'feature/home/data/repository/news/home_repository_impl.dart';
import 'feature/home/domain/repository/news/home_repository.dart';
import 'feature/home/domain/usecase/get_top_headlines_news_uc.dart';
import 'feature/home/presentation/cubits/home_news_helper/home_news_helper_cubit.dart';
import 'feature/search/data/data_sources/search_remote_data_source.dart';
import 'feature/search/data/repositories/search_repository_impl.dart';
import 'feature/search/domain/repositories/search_repository.dart';
import 'feature/search/domain/usecases/search_top_headlines_news_uc.dart';
import 'feature/home/presentation/blocs/top_headlines_news/top_headlines_news_bloc.dart';
import 'package:get_it/get_it.dart';

import 'feature/search/presentation/blocs/search_top_headlines/search_top_headlines_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => Dio());
  sl.registerFactory(() => ApiService(dio: sl()));
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // Data Source
  sl.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(apiService: sl()));
  sl.registerLazySingleton<SearchRemoteDataSource>(
      () => SearchRemoteDataSourceImpl(apiService: sl()));

  // Repository
  sl.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(newsRemoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<SearchRepository>(
      () => SearchRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));

  // Use Case
  sl.registerLazySingleton(() => GetTopHeadlinesNewsUc(newsRepository: sl()));
  sl.registerLazySingleton(() => SearchTopHeadlinesNewsUc(repository: sl()));

  sl.registerFactory(
    () => TopHeadlinesNewsBloc(getTopHeadlinesNews: sl()),
  );
  sl.registerFactory(
    () => HomeNewsHelperCubit(),
  );
  sl.registerFactory(
    () => SearchTopHeadlinesBloc(searchTopHeadlinesNews: sl()),
  );
}
