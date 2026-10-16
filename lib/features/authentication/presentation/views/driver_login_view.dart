import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasselni_driver/core/theme/app_colors.dart';
import 'package:wasselni_driver/features/authentication/presentation/controllers/login_controller.dart';
import 'package:wasselni_driver/features/authentication/presentation/widgets/login_form.dart';
import 'package:wasselni_driver/features/authentication/presentation/widgets/login_header.dart';

class DriverLoginView extends ConsumerStatefulWidget {
  const DriverLoginView({super.key});

  @override
  ConsumerState<DriverLoginView> createState() => _DriverLoginViewState();
}

class _DriverLoginViewState extends ConsumerState<DriverLoginView> {
  Future<void> _handleLogin(String phone, String password) async {
    try {
      await ref
          .read(loginControllerProvider.notifier)
          .login(phone: phone, password: password);

      if (!mounted) return;

      // Navigator.pushAndRemoveUntil(
      //   context,
      //   // MaterialPageRoute(builder: (_) => const MainNavigationView()),
      //   // (route) => false,
      // );
    } catch (error) {
      if (!mounted) return;

      final message = error is Exception
          ? error.toString().replaceFirst('Exception: ', '')
          : 'حدث خطأ أثناء تسجيل الدخول';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: AppColors.error),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const LoginHeader(),
                  const SizedBox(height: 40),
                  LoginForm(
                    isLoading: loginState.isLoading,
                    onLogin: _handleLogin,
                    onForgotPassword: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('استعادة كلمة المرور هتتضاف لاحقًا'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
