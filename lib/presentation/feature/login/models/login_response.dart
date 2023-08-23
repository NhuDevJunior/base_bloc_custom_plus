import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  String access_token;
  int expires_in;
  String token_type;
  String scope;
  String? error;

  LoginResponse({
    required this.access_token,
    required this.expires_in,
    required this.token_type,
    required this.scope,
    this.error
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}