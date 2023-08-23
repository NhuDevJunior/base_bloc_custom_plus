import 'package:bloc_base_source/helper/logger/logger.dart';
import 'package:bloc_base_source/presentation/routers/app_router.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bloc/base_bloc.dart';
import '../../../../core/bloc/event.dart';
import '../../../../core/bloc/state.dart';
import '../../../../di/locator.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';
import '../remote/repository/login_repository.dart';
import 'login_event.dart';

class LoginBloc extends BaseBloc {
  final LoginRepository _loginRepository;
  String userName = "";
  String password = "";

  LoginBloc(this._loginRepository) : super(const InitialState());

  @override
  Future<void> handleEvent(BaseEvent event, Emitter<BaseState> emit) async {
    if (event is LoginUsernameChanged) {
      userName = event.username;
    } else if (event is LoginPasswordChanged) {
      password = event.password;
    } else if (event is LoginSubmitted) {
      await safeDataCall(
        emit,
        callToHost:
            _loginRepository.performLogin({
              "grant_type": "password",
              "username": "hcm_thcs_viettel9",
              "password": "Abc@123456",
              "scope": "openid profile IdentityService TenantService InternalGateway BackendAdminAppGateway EmployeeService CategoryService SmasCustomerService AdminSettingService SettingService ClassroomSupervisorService StudentService ScoreBookService MongoDynamicPageService",
              "client_id": "backend-admin-app-client",
              "client_secret": "1q2w3e*"
            }),
        success: (Emitter<BaseState> emit, LoginResponse? data) {
          AppLog.d("login success data - ${data?.token_type}");
          hideDialogState();
          token = data?.token_type ?? "";
          navigationService.pushAndRemoveUntil(
            const HomeRoute(),
            predicate: (route) => false,
          );
        },
      );
    }
  }
}
