import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../data/remote/dto/model_base_response.dart';
import '../../../../../data/remote/service/service_constants.dart';
import '../../models/login_request.dart';
import '../../models/login_response.dart';

part 'login_service.g.dart';

@RestApi(baseUrl: "https://sso.vtsmas.vn/")
abstract class LoginService {
  factory LoginService(Dio dio) = _LoginService;
  // @FormUrlEncoded()
  // @POST('connect/token')
  // Future<ModelBaseResponse<LoginResponse>> performLogin(@Body() Map<String, String> loginRequest);
  @FormUrlEncoded()
  @POST('connect/token')
  Future<LoginResponse> performLogin(@Body() Map<String, String> loginRequest);
}
