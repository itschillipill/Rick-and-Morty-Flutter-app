import 'package:dio/dio.dart';

class DioClient {
  static final Dio _dio = Dio();

  Future<List<Map<String, dynamic>>> getAllEntities(
    String url, {
    bool showResults = true,
  }) async {
    try {
      final response = await _dio.get(url);
      print(response.data);
      if (showResults) {
        return List<Map<String, dynamic>>.from(response.data['results']);
      }
      return List<Map<String, dynamic>>.from(response.data);
    } on DioException {
      rethrow;
    }
  }
}
