import 'package:get/get.dart';
import 'package:to_do_list_app/features/tasks/presentation/screens/edit_task_screen.dart';
import '../../features/login/presentation/screens/login_screen.dart';
import '../../features/login/presentation/screens/signup_screen.dart';
import '../../features/login/presentation/screens/welcome_screen.dart';
import '../../features/login/widgets/splash_screen.dart';
import '../../features/tasks/controller/bindings/task_binding.dart';
import '../../features/tasks/presentation/screens/home_screen.dart';
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
      binding:TaskBinding()
    ),
    GetPage(name:AppRoutes.editTask,
    page: ()=>const EditTaskScreen())
  ];
}