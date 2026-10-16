import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wasselni_driver/core/theme/app_theme.dart';
import 'package:wasselni_driver/features/splash/presentation/view/splash_view.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const WasselniDriverApp());
}

class WasselniDriverApp extends StatelessWidget {
  const WasselniDriverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wasselni Driver',
      debugShowCheckedModeBanner: false,
      theme:  AppTheme.light,
      home: const SplashView(),
    );
  }
}
