import 'package:bloc_base_source/presentation/feature/login/view/login_screen.dart';
import 'package:bloc_base_source/presentation/routers/app_router.dart';
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
        // routerDelegate: _appRouter.delegate(),
        // routeInformationParser: _appRouter.defaultRouteParser(),
        initialRoute:"/login_screen",
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/login_screen': (context) => const LoginScreen(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/home_screen': (context) => const HomeScreen(),
        },
    );
  }
}
