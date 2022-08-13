import 'package:apex/data/local/hat.dart';
import 'package:apex/data/local/storage.dart';
import 'package:dio/dio.dart';
import 'package:encrypt/encrypt.dart';

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.path.contains("dashboard")) {
      var a = Encrypted.from64(AppStorage.instance.getRequestToken() ?? "");
      var token =
          BlackHat().decryptWithAES(AppStorage.instance.getPinCode() ?? "", a);

      options.headers['Authorization'] = 'Bearer $token';

      return handler.next(options);
    } else {
      super.onRequest(options, handler);
    }
  }

  @override
  void onError(DioError dioError, ErrorInterceptorHandler handler) {
    if (dioError.response?.statusCode != null &&
        dioError.response!.statusCode! > 399) {
      handler.resolve(
        Response(
          requestOptions: dioError.requestOptions,
          data: dioError.response?.data,
        ),
      );
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler); //add this line
  }
}
