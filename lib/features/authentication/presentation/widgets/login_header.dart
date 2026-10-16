import 'package:flutter/material.dart';
import 'package:wasselni_driver/core/theme/app_colors.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Image.asset(
            'assets/images/remove_the_bottom_tagline_text_fast_safe_anywhere_completely._keep_the_rest_of.png',
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'مرحباً بك في واصلني',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: AppColors.black,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'سجّل دخولك وابدأ رحلتك في التوصيل',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: AppColors.grey),
        ),
      ],
    );
  }
}
