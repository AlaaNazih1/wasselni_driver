import 'package:flutter/material.dart';
import 'package:wasselni_driver/core/theme/app_colors.dart';
import 'package:wasselni_driver/core/widgets/custom_text_form_field.dart';

class DriverPasswordField extends StatefulWidget {
  const DriverPasswordField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  State<DriverPasswordField> createState() => _DriverPasswordFieldState();
}

class _DriverPasswordFieldState extends State<DriverPasswordField> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: widget.controller,
      labelText: 'كلمة المرور',
      hintText: 'أدخل كلمة المرور',
      obscureText: _obscurePassword,
      prefixIcon: const Icon(Icons.lock_outline_rounded, color: AppColors.grey),
      suffixIcon: IconButton(
        onPressed: () {
          setState(() {
            _obscurePassword = !_obscurePassword;
          });
        },
        icon: Icon(
          _obscurePassword
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
          color: AppColors.grey,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'من فضلك أدخل كلمة المرور';
        }

        return null;
      },
    );
  }
}
