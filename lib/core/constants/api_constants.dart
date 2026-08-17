// lib/core/constants/api_constants.dart
class ApiConstants {
  ApiConstants._();

  // Base URL
  static const String baseUrl = 'https://fakestoreapi.com/';
  static const String apiVersion = '/api/v1';

  // Auth Endpoints
  static const String login = '/auth/login';
  static const String register = '/users';
  static const String products = '/products';

  // Timeout
  static const int timeoutSeconds = 30;
}