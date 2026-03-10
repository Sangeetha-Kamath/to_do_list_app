import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/widgets/app_text_field.dart';
import '../../../../../../core/widgets/password_text_field.dart';
import '../../../../../../core/widgets/primary_button.dart';

import '../../../../core/routes/app_routes.dart';
import '../../controller/auth_controller.dart';
import '../../widgets/auth_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screenPadding,
          child: Form(
            key: controller.loginFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AuthHeader(
                  title: 'Welcome back',
                  subtitle: 'Log in to continue managing your tasks.',
                  showIcon: false,
                ),
                AppSpacing.gapXxxl,
                AppTextField(
                  controller: controller.loginEmailController,
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  prefixIcon: const Icon(Icons.email_outlined),
                  validator: controller.validateEmail,
                ),
                AppSpacing.gapLg,
                PasswordTextField(
                  controller: controller.loginPasswordController,
                  textInputAction: TextInputAction.done,
                  validator: controller.validatePassword,
                ),
                AppSpacing.gapMd,
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Forgot Password?'),
                  ),
                ),
                AppSpacing.gapXl,
                Obx(
                  () => PrimaryButton(
                    text: 'Log In',
                    isLoading: controller.isLoginLoading.value,
                    onPressed: controller.login,
                  ),
                ),
                AppSpacing.gapXxl,
                Center(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        "Don’t have an account? ",
                        style: textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () { 
                          controller.clearLoginFields();
                          Get.offNamed(AppRoutes.signup);
                        
                        },
                        child: Text(
                          'Sign Up',
                          style: textTheme.bodyMedium?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}