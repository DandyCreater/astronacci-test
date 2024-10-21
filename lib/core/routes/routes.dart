import 'package:astronacci/feature/auth/presentation/screen/register_screen.dart';
import 'package:astronacci/feature/auth/presentation/screen/reset_password_screen.dart';
import 'package:astronacci/feature/dashboard/data/model/user_resp_model.dart';
import 'package:astronacci/feature/dashboard/presentation/dashboard_screen.dart';
import 'package:astronacci/feature/dashboard/presentation/user_detail_screen.dart';
import 'package:astronacci/feature/profile/presentation/screen/edit_profile_screen.dart';
import 'package:astronacci/feature/profile/presentation/screen/profile_screen.dart';
import 'package:astronacci/feature/splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';

import '../../feature/auth/presentation/screen/login_screen.dart';
import '../../feature/profile/presentation/screen/change_password_screen.dart';
import '../constanta/constanta_string.dart';

class AppRouter {
  Route onGenerate(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteConstanta.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteConstanta.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case RouteConstanta.dashboardScreen:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case RouteConstanta.userDetail:
        return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => UserDetailScreen(
                userDetail: routeSettings.arguments as UserDetail));
      case RouteConstanta.registerScreen:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case RouteConstanta.profileScreen:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case RouteConstanta.editProfileScreen:
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());
      case RouteConstanta.resetPasswordScreen:
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());
      case RouteConstanta.changePasswordScreen:
        return MaterialPageRoute(builder: (_) => const ChangePasswordScreen());

      default:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) =>
              const Center(child: Text("Halaman sedang dalam Pengembangan")),
        );
    }
  }
}
