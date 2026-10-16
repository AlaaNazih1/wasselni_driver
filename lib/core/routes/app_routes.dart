import 'package:flutter/material.dart';
import 'package:wasselni_driver/features/authentication/presentation/views/driver_login_view.dart';

class AppRoutes {
  static const String login = '/login';
 

  static Map<String, WidgetBuilder> routes = {
    login: (context) => const DriverLoginView(),
   
  };
}
