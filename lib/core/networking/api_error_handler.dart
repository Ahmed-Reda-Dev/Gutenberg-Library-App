import 'package:dio/dio.dart';

class ApiError {
  final String? message;
  final int? statusCode;

  ApiError({this.message, this.statusCode});
}

class ApiErrorHandler {
  static ApiError handle(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiError(
          message: 'Connection timeout, please try again later',
          statusCode: error.response?.statusCode,
        );
      case DioExceptionType.connectionError:
        return ApiError(
          message: 'No internet connection',
          statusCode: error.response?.statusCode,
        );
      case DioExceptionType.badResponse:
        return _handleResponseError(error);
      default:
        return ApiError(
          message: 'Something went wrong, please try again later',
          statusCode: error.response?.statusCode,
        );
    }
  }

  static ApiError _handleResponseError(DioException error) {
    final statusCode = error.response?.statusCode;
    final message = error.response?.data['message'] ?? 'Unknown error occurred';

    switch (statusCode) {
      case 400:
        return ApiError(message: 'Bad request', statusCode: statusCode);
      case 401:
        return ApiError(message: 'Unauthorized', statusCode: statusCode);
      case 403:
        return ApiError(message: 'Forbidden', statusCode: statusCode);
      case 404:
        return ApiError(message: 'Not found', statusCode: statusCode);
      case 500:
        return ApiError(
          message: 'Internal server error',
          statusCode: statusCode,
        );
      default:
        return ApiError(message: message, statusCode: statusCode);
    }
  }
}
