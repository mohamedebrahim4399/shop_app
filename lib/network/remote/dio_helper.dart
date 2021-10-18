import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() async {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData(
      {required String url,
      Map<String, dynamic>? query,
      lang = 'en',
      token = ''}) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token
    };
    return await dio!.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postDate(
      {required String url,
      Map<String, dynamic>? query,
      required Map<String, dynamic> data,
      lang = 'en',
      token = ''}) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token
    };
    return await dio!.post(url, queryParameters: query, data: data);
  }

  static Future<Response> putDate(
      {required String url,
        Map<String, dynamic>? query,
        required Map<String, dynamic> data,
        lang = 'en',
        token = ''}) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token
    };
    return await dio!.put(url, queryParameters: query, data: data);
  }
}
