import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_radius.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/widgets/app_outlined_button.dart';
import '../../../../../../core/widgets/primary_button.dart';
import 'login_screen.dart';
import 'signup_screen.dart';
import '../../widgets/auth_header.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),

              Center(
                child: Container(
                  height: 220,
                  width: 220,
                  decoration: BoxDecoration(
                    color: AppColors.primarySoft,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 132,
                        width: 132,
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(AppRadius.xxl),
                          border: Border.all(color: AppColors.border),
                        ),
                      ),
                      Positioned(
                        top: 62,
                        child: Container(
                          width: 84,
                          height: 10,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 90,
                        child: Column(
                          children: List.generate(
                            3,
                            (index) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.check_circle,
                                    color: AppColors.success,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    width: 64,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: index == 2
                                          ? AppColors.border
                                          : AppColors.textPrimary.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(999),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              const AuthHeader(
                title: 'Organize your day',
                subtitle:
                    'Plan tasks, stay focused, and manage everything in one clean workspace.',
              ),

              const SizedBox(height: AppSpacing.xxxl),

              PrimaryButton(
                text: 'Log In',
                onPressed: () => Get.to(() => const LoginScreen()),
              ),

              const SizedBox(height: AppSpacing.lg),

              AppOutlinedButton(
                text: 'Create Account',
                onPressed: () => Get.to(() => const SignUpScreen()),
              ),

              const SizedBox(height: AppSpacing.xl),

              Center(
                child: Text(
                  'Simple. Fast. Productive.',
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}