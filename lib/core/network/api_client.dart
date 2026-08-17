import 'package:dio/dio.dart';

class ApiClient {
  late final Dio _dio;

  ApiClient({required String baseUrl, Map<String, String>? headers}) {
    _dio = Dio(BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(seconds: 30),
        receiveTimeout: Duration(seconds: 60),
        headers: headers ?? {'Content-Type': 'application/json'}));
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
    ),);
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Add Auth token
        final token = await _getStoredToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          // Token expired - logout करें
        }
        return handler.next(error);
      },
    ),);

  }
  Dio get dio => _dio;
  Future<String?> _getStoredToken() async {
    // token form SharedPreferences
    return null; // placeholder
  }
}