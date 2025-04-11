// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:settee/src/model/dio_exception.dart';

class DioClient {
  static final _baseOptions = BaseOptions(
    baseUrl: 'http://10.0.2.2:8000/api',
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Cookie':
          'XSRF-TOKEN=eyJpdiI6Inc1YW0wQ29WVlJaUUF3V2RkUXRVaVE9PSIsInZhbHVlIjoibDkrMmRmSFFNQkxZbENybFFscXo1d3hHUXAySFVBWE1XbEthRFoybStRT0ZETk9BcXlLRXkrQmZYSnRzODZ6aHRjamtNZ1RyK2VKbmFlS3BNTGtSS1g1NnhjNjJ0RHVReUVjTFpBMzhlaytCc3hVWDBJZWxNOTVUYURrakRud3YiLCJtYWMiOiIzYzNmOTU1NDA0ODkxZTU3NWQzMDQyMmMzZThmMDU2OWQ3ODkzYTY2ZGI1ZWViNmU0M2VmMmMwZDBhYjg1YzlmIn0%3D; laravel_session=eyJpdiI6IndwREYyUnNob3B2aUtiam5JdEE0ckE9PSIsInZhbHVlIjoiL1FUejBJbUEwcG9lWnl5NmtXVlQzQ1VRVzZZWEhZZDIwbnpnNFBuSTBuclpESjBKTkhPaFdhdlFTQWFuNUh4MWErOGdSTVdkVkZyYnEvOEJ1RVhTWUEvRlA0TlRPZC9jL0NVZlRRWkRCaUZXUHlEYWNqVTIzV2hwZnBPZzhVVjEiLCJtYWMiOiIzZDczOWM1Y2ViZDE0OTE2N2M5ODYyNDdkMmRlYzMyOGUwNjU2MmY0NTcxZGU2NGI4MTM1ZTEwZWE2MGY5ZWVmIn0%3D',
    },
  );

  static String _token = '';

  static Future<String> _getToken() async {
    final random = Random.secure();
    var values = List<int>.generate(8, (i) => random.nextInt(256));
    _token = base64Url.encode(values);
    return _token;
  }

  String createToken() {
    final random = Random.secure();
    var values = List<int>.generate(8, (i) => random.nextInt(256));
    return base64Url.encode(values);
  }

  // * POST: '/register'
  static Future<dynamic> postRegister(
      String userName,
      String birthday,
      String nickName,
      String password,
      String imageName,
      String base64Image,
      String email,
      String phone) async {
    final token = await _getToken();
    var dio = Dio(_baseOptions);
    dio.options.headers['X-CSRF-TOKEN'] = token;
    try {
      final response = await dio.post('/register', data: {
        'username': userName,
        'nickname': nickName,
        'email': email,
        'password': password,
        'phone': phone,
        'birthday': birthday,
        'image_name': imageName,
        'image_file': base64Image,
      });
      return response.data;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  // * POST: '/compare_nickname'
  static Future<dynamic> postCompareNickname(String nickName) async {
    final token = await _getToken();
    var dio = Dio(_baseOptions);
    dio.options.headers['X-CSRF-TOKEN'] = token;
    try {
      final response =
          await dio.post('/compare_nickname', data: {'nickname': nickName});
      return response.data;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  // * POST: '/login_action'
  static Future<dynamic> postLoginAction(String emailOrNumber) async {
    final token = await _getToken();
    var dio = Dio(_baseOptions);
    dio.options.headers['X-CSRF-TOKEN'] = token;
    try {
      final response = await dio
          .post('/login_action', data: {'email_number': emailOrNumber});
      print(response.data);
      return response.data;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  // * POST: '/login_with_password'
  static Future<dynamic> loginWithPassword(
      String emailOrNumber, String password) async {
    final token = await _getToken();
    var dio = Dio(_baseOptions);
    dio.options.headers['X-CSRF-TOKEN'] = token;
    try {
      final response = await dio.post('/login_with_password',
          data: {'email_number': emailOrNumber, 'password': password});
      print(response.data);
      return response.data;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
