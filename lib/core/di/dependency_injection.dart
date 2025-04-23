import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import '../networking/api_constants.dart';
import '../networking/api_service.dart';
import '../networking/dio_factory.dart';
import '../../features/home/data/models/book_model.dart';
import '../../features/home/data/repositories/book_repository_impl.dart';
import '../../features/home/domain/repositories/book_repository.dart';
import '../../features/home/domain/usecases/get_books_usecase.dart';
import '../../features/home/domain/usecases/search_books_usecase.dart';
import '../../features/home/presentation/cubit/book_cubit.dart';

final getIt = GetIt.instance;

class DependencyInjection {
  static Future<void> init() async {
    // External - Use DioFactory instead of creating a new Dio instance
    final dio = DioFactory.getDio();

    getIt.registerLazySingleton<Dio>(() => dio);

    // Register API Service
    getIt.registerLazySingleton<ApiService>(
      () => ApiService(getIt<Dio>(), baseUrl: ApiConstants.apiBaseUrl),
    );

    // Register Hive boxes
    final booksBox = await Hive.openBox<BookModel>('books');
    getIt.registerLazySingleton<Box<BookModel>>(() => booksBox);

    // Register repositories
    getIt.registerLazySingleton<BookRepository>(
      () => BookRepositoryImpl(getIt<ApiService>(), getIt<Box<BookModel>>()),
    );

    // Register use cases
    getIt.registerLazySingleton<GetBooksUseCase>(
      () => GetBooksUseCase(getIt<BookRepository>()),
    );

    getIt.registerLazySingleton<SearchBooksUseCase>(
      () => SearchBooksUseCase(getIt<BookRepository>()),
    );

    // Register Cubits
    getIt.registerFactory<BookCubit>(
      () => BookCubit(getIt<GetBooksUseCase>(), getIt<SearchBooksUseCase>()),
    );
  }
}
