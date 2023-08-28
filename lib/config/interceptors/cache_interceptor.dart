import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheInterceptor implements InterceptorsWrapper {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    //TODO: implement onRequest
    handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    if (response.requestOptions.method == 'GET') {
      final instance = await SharedPreferences.getInstance();
      instance.setString(
        'notes',
        jsonEncode(response.data),
      );
    }
    handler.resolve(response);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final instance = await SharedPreferences.getInstance();
    final json = instance.getString('notes');
    if (json != null) {
      final data = jsonDecode(json);
      handler.resolve(Response(requestOptions: err.requestOptions, data: data));
    }
  }
}
