import 'package:bloc_base_source/presentation/feature/login/view/login_screen.dart';
import 'package:bloc_base_source/presentation/routers/app_router.dart';
import 'package:bloc_base_source/presentation/routers/router_helper.dart';
import 'package:flutter/material.dart';
import 'di/locator.dart';
import 'presentation/feature/home/view/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppRouter _appRouter = locator<AppRouter>();
    return MaterialApp(
        title: 'Flutter Clean Architecture Sample',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      home: const LoginScreen(),
      navigatorKey: navigatorKey,
      onGenerateRoute: (settings) {
        return RouteHelper.getRoute(settings);
      },
    );
  }
  }
