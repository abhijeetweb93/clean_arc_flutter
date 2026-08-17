import 'dart:convert';
import 'package:flutter/services.dart';

class AssetLoader {
  static Future<Map<String, dynamic>> loadHomeData() async {
    final String jsonString = await rootBundle.loadString('assets/mock/home_data.json');
    return json.decode(jsonString);
  }
}