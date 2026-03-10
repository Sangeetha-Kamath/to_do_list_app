import 'package:get/get.dart';

import '../../screens/home/home_screen.dart' show HomeScreen;
import '../../screens/login/controller/bindings/auth_binding.dart';
import '../../screens/login/login_screen.dart';
import '../../screens/login/signup_screen.dart';
import '../../screens/login/welcome_screen.dart';
import '../../screens/login/widgets/splash_screen.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.welcome,
      page: () => const WelcomeScreen(),
    
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => const SignUpScreen(),
     
     

    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
    ),
  ];
}