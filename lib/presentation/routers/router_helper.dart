import 'package:bloc_base_source/core/widget/slide_right_route.dart';
import 'package:bloc_base_source/presentation/feature/home/view/home_screen.dart';
import 'package:bloc_base_source/presentation/feature/login/view/login_screen.dart';
import 'package:flutter/cupertino.dart';

import 'app_path.dart';

class RouteHelper {
  static getRoute(RouteSettings settings){
    switch (settings.name) {
      case AppPath.loginScreen:
        return SlideRightRoute(widget:const LoginScreen());
      case AppPath.homeScreen:
        return SlideRightRoute(widget:const HomeScreen());
    }
  }
}