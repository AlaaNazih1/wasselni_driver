import 'package:flutter/material.dart';
import 'package:wasselni_driver/core/theme/app_colors.dart';
import 'package:wasselni_driver/core/widgets/custom_button.dart';
import 'package:wasselni_driver/core/widgets/custom_text_button.dart';
import 'package:wasselni_driver/features/authentication/presentation/widgets/driver_password_field.dart';
import 'package:wasselni_driver/features/authentication/presentation/widgets/driver_phone_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
    required this.onLogin,
    required this.onForgotPassword,
    this.isLoading = false,
  });

  final void Function(String phone, String password) onLogin;
  final VoidCallback onForgotPassword;
  final bool isLoading;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    widget.onLogin(_phoneController.text.trim(), _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DriverPhoneField(controller: _phoneController),
          const SizedBox(height: 18),
          DriverPasswordField(controller: _passwordController),
          const SizedBox(height: 8),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: CustomTextButton(
              text: 'نسيت كلمة المرور؟',
              color: AppColors.grey,
              underline: false,
              onPressed: widget.onForgotPassword,
            ),
          ),
          const SizedBox(height: 22),
          CustomButton(
            text: widget.isLoading ? 'جاري تسجيل الدخول...' : 'تسجيل الدخول',
            isLoading: widget.isLoading,
            onPressed: widget.isLoading ? null : _submit,
          ),
        ],
      ),
    );
  }
}
