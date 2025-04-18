import 'package:dio/dio.dart';

import 'package:settee/src/utils/string_hardcoded.dart';

class DioExceptions implements Exception {
  late String message;

  DioExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = "Request to API server was cancelled".hardcoded;
        break;
      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with API server".hardcoded;
        break;
      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with API server".hardcoded;
        break;
      default:
        message = "Something went wrong".hardcoded;
        break;
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'Bad request'.hardcoded;
      case 401:
        return 'Unauthorized'.hardcoded;
      case 403:
        return 'Forbidden'.hardcoded;
      case 404:
        return error['message'];
      case 500:
        return 'Internal server error'.hardcoded;
      case 502:
        return 'Bad gateway'.hardcoded;
      default:
        return 'Oops, something went wrong'.hardcoded;
    }
  }

  @override
  String toString() => message;
}
