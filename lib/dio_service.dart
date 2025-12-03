import 'package:dio/dio.dart';
class DioService {

  static const String baseUrl = 'http://lab12_test_lntu.requestcatcher.com';
  final Dio _dio = Dio();

  Future<void> sendData(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(
        '$baseUrl/$endpoint',
        data: data,
      );
    } catch (e) {
    }
  }
}