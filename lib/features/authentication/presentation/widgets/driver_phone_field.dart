import 'package:flutter/material.dart';
import 'package:wasselni_driver/core/theme/app_colors.dart';
import 'package:wasselni_driver/core/widgets/custom_text_form_field.dart';

class DriverPhoneField extends StatelessWidget {
  const DriverPhoneField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: controller,
      labelText: 'رقم الهاتف',
      hintText: '01XXXXXXXXX',
      keyboardType: TextInputType.phone,
      prefixIcon: const Icon(
        Icons.phone_android_rounded,
        color: AppColors.grey,
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'من فضلك أدخل رقم الهاتف';
        }

        if (!RegExp(r'^01[0125][0-9]{8}$').hasMatch(value.trim())) {
          return 'أدخل رقم هاتف مصري صحيح';
        }

        return null;
      },
    );
  }
}
