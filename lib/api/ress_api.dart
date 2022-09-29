import 'package:dio/dio.dart';
import 'package:ress_app/services/local_storage.dart';

class RessApi {
  static final Dio _dio = Dio();

  static void configureDio() {
    // _dio.options.baseUrl = 'http://localhost:8080/api';
    _dio.options.baseUrl = 'https://ress-aa-app.herokuapp.com/api';

    //Headers
    _dio.options.headers = {
      'x-token': LocalStorage.prefs.getString('x-token') ?? ''
    };
  }

  static Future httpGet(String path) async {
    try {
      final resp = await _dio.get(path);
      return resp.data;
    } on DioError catch (e) {
      throw ('Error en el GET $e');
    }
  }

  static Future post(String path, Map<String, dynamic> data) async {
    // final formData = FormData.fromMap(data);
    try {
      final resp = await _dio.post(path, data: data);

      return resp.data;
    } catch (e) {
      // print(e);
      throw 'Error en el POST';
    }
  }

  static Future put(String path, Map<String, dynamic> data) async {
    // final formData = FormData.fromMap(data);
    try {
      final resp = await _dio.put(path, data: data);

      return resp.data;
    } catch (e) {
      // print(e);
      throw 'Error en el PUT';
    }
  }

  static Future delete(String path, Map<String, dynamic> data) async {
    // final formData = FormData.fromMap(data);
    try {
      final resp = await _dio.delete(path, data: data);

      return resp.data;
    } catch (e) {
      // print(e);
      throw 'Error en el DELETE';
    }
  }
}
