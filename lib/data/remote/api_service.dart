import 'package:apex/models/resgister_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://smart-pay-mobile.herokuapp.com/api/v1")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST("/auth/email")
  @FormUrlEncoded()
  Future<Map<String, dynamic>?> getEmailToken(@Field() String email);

  @POST("/auth/email/verify")
  @FormUrlEncoded()
  Future<Map<String, dynamic>?> verifyEmailToken(
      @Field() String email, @Field() String token);

  @POST("/auth/register")
  @FormUrlEncoded()
  Future<Map<String, dynamic>?> register(@Field() RegisterUser user);

  @POST("/auth/login")
  @FormUrlEncoded()
  Future<Map<String, dynamic>?> login(
      @Field() String email, @Field() String password, @Field() String device);

  @GET("/dashboard")
  Future<Map<String, dynamic>?> dashboard();
}
