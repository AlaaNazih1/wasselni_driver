import 'package:flutter/material.dart';
import 'package:wasselni_driver/features/authentication/presentation/views/driver_login_view.dart';
import 'package:wasselni_driver/features/main/presentation/views/main_navigation_view.dart';

class AppRoutes {
  static const String login = '/login';
  static const String mainNavigation = '/main-navigation';
 

  static Map<String, WidgetBuilder> routes = {
    login: (context) => const DriverLoginView(),
    mainNavigation: (context) => const MainNavigationView(),
   
  };
}
