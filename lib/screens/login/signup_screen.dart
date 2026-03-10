import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list_app/core/theme/app_radius.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/password_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../core/routes/app_routes.dart';
import 'controller/auth_controller.dart';
import 'login_screen.dart';
import 'widgets/auth_header.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
            key: controller.signupFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AuthHeader(
                  title: 'Create account',
                  subtitle: 'Sign up to start organizing your daily tasks.',
                  showIcon: false,
                ),
                AppSpacing.gapXxxl,
                AppTextField(
                  controller: controller.signupNameController,
                  labelText: 'Full Name',
                  hintText: 'Enter your full name',
                  textInputAction: TextInputAction.next,
                  prefixIcon: const Icon(Icons.person_outline),
                  validator: controller.validateName,
                ),
                AppSpacing.gapLg,
                AppTextField(
                  controller: controller.signupEmailController,
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  prefixIcon: const Icon(Icons.email_outlined),
                  validator: controller.validateEmail,
                ),
                AppSpacing.gapLg,
                PasswordTextField(
                  controller: controller.signupPasswordController,
                  hintText: 'Create a password',
                  textInputAction: TextInputAction.next,
                  validator: controller.validatePassword,
                ),
                AppSpacing.gapLg,
                PasswordTextField(
                  controller: controller.signupConfirmPasswordController,
                  labelText: 'Confirm Password',
                  hintText: 'Re-enter your password',
                  textInputAction: TextInputAction.done,
                  validator: controller.validateConfirmPassword,
                ),
                AppSpacing.gapXxl,
                Obx(
                  () => PrimaryButton(
                    text: 'Create Account',
                    isLoading: controller.isSignupLoading.value,
                    onPressed: controller.signUp,
                  ),
                ),
                AppSpacing.gapXxl,
                Center(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.offNamed(AppRoutes.login),
                        child: Text(
                          'Log In',
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