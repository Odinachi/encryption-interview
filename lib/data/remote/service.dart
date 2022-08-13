import 'package:apex/models/get_email_token_response.dart';
import 'package:apex/models/resgister_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'service.g.dart';

@RestApi(baseUrl: "https://smart-pay-mobile.herokuapp.com/api/v1")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST("/auth/email")
  @FormUrlEncoded()
  Future<GetTokenResponse> getEmailToken(@Field() String email);

  @POST("/auth/email/verify")
  @FormUrlEncoded()
  Future<GetTokenResponse> verifyEmailToken(
      @Field() String email, @Field() String token);

  @POST("/auth/register")
  @FormUrlEncoded()
  Future<GetTokenResponse> register(@Field() RegisterUser user);

  @POST("/auth/login")
  @FormUrlEncoded()
  Future<GetTokenResponse> login(
      @Field() String email, @Field() String password, @Field() String device);

  @POST("/dashboard")
  Future<GetTokenResponse> dashboard(@Header("Token") String token);
}
