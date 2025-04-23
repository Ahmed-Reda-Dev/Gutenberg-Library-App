import 'package:book_listing_app/core/networking/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../features/home/data/models/books_response.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET(ApiConstants.booksPath)
  Future<BooksResponse> getBooks({
    @Query('page') int? page,
    @Query('search') String? query,
  });
}
