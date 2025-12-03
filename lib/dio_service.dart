import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';


class DioService {

  static const String baseUrl = 'http://lab12_test_lntu.requestcatcher.com';
  final Dio _dio = Dio();

  DioService() {
    (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient();
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

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

