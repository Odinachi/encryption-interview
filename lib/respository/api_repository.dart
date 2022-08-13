import 'package:apex/data/remote/api_service.dart';
import 'package:apex/models/get_email_token_response.dart';
import 'package:apex/models/resgister_response.dart';
import 'package:apex/models/verify_email_token_response.dart';
import 'package:apex/res/assets.dart';
import 'package:apex/respository/interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tuple/tuple.dart';

class ApiRepository extends _ApiService {
  late ApiService _service;
  static final ApiRepository instance = ApiRepository._internal();
  ApiRepository._internal() {
    _service = ApiService(
      super.getDioWith(interceptors: [ApiInterceptors()]),
    );
  }

  Future<Tuple2<RegisterData?, String?>> register(RegisterUser user) async {
    var request = await _service.register(user);
    if (request?['status'] == true) {
      return Tuple2(RegisterData.fromJson(request?['data']), null);
    }
    return Tuple2(
      null,
      _getErrorMessage(request),
    );
  }

  Future<Tuple2<TokenData?, String?>> getToken(String email) async {
    var request = await _service.getEmailToken(email);
    if (request?['status'] == true) {
      return Tuple2(TokenData.fromJson(request?['data']), null);
    }
    return Tuple2(
      null,
      _getErrorMessage(request),
    );
  }

  Future<Tuple2<VerifyTokenData?, String?>> verifyEmail(
      String email, String token) async {
    var request = await _service.verifyEmailToken(email, token);
    if (request?['status'] == true) {
      return Tuple2(VerifyTokenData.fromJson(request?['data']), null);
    }
    return Tuple2(
      null,
      _getErrorMessage(request),
    );
  }

  Future<Tuple2<VerifyTokenData?, String?>> login(
      String email, String password) async {
    var request = await _service.login(
        email, password, await AppAssets.getDeviceId() ?? "");
    if (request?['status'] == true) {
      return Tuple2(VerifyTokenData.fromJson(request?['data']), null);
    }
    return Tuple2(
      null,
      _getErrorMessage(request),
    );
  }

  Future<Tuple2<VerifyTokenData?, String?>> dashboard() async {
    var request = await _service.dashboard();
    if (request?['status'] == true) {
      return Tuple2(VerifyTokenData.fromJson(request?['data']), null);
    }
    return Tuple2(
      null,
      _getErrorMessage(request),
    );
  }

  String _getErrorMessage(Map<String, dynamic>? value) {
    if (value?["message"] != null) {
      return value?["message"];
    } else {
      return "something Happened, Please try again";
    }
  }
}

abstract class _ApiService {
  final BaseOptions options = BaseOptions(
    responseType: ResponseType.json,
    connectTimeout: 55800,
    receiveTimeout: 59250,
  );

  Dio _instance() {
    Dio dio = Dio(options)
      ..interceptors.add(
        PrettyDioLogger(
            requestBody: !kReleaseMode,
            requestHeader: !kReleaseMode,
            responseBody: !kReleaseMode,
            responseHeader: !kReleaseMode,
            compact: false,
            error: !kReleaseMode ? true : false,
            maxWidth: 90),
      );

    return dio;
  }

  Dio getDioWith({required List<Interceptor> interceptors}) {
    return _instance()..interceptors.addAll(interceptors);
  }
}
