import 'package:injectable/injectable.dart';

import '../../../../../core/common/result.dart';
import '../../../../../data/repository/base_repository.dart';
import '../../models/login_request.dart';
import '../../models/login_response.dart';
import '../service/login_service.dart';
import 'login_repository.dart';

@Injectable(as: LoginRepository)
class LoginRepositoryImpl extends BaseRepository implements LoginRepository {
  final LoginService _loginService;

  LoginRepositoryImpl(this._loginService);

  @override
  Future<Result<LoginResponse>> performLogin(Map<String, String> model) {
    return safeApiCallNoBase(_loginService.performLogin(model));
  }
}
