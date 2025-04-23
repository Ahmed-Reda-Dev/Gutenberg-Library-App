import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../networking/api_client.dart';
import '../networking/dio_factory.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Core
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<ApiClient>(() => ApiClient(dio));
}
