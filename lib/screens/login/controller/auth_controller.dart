import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/routes/app_routes.dart';
import '../services/auth_service.dart';


class AuthController extends GetxController {
  final AuthService _authService = AuthService.instance;

  final loginFormKey = GlobalKey<FormState>();
  final signupFormKey = GlobalKey<FormState>();

  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  final signupNameController = TextEditingController();
  final signupEmailController = TextEditingController();
  final signupPasswordController = TextEditingController();
  final signupConfirmPasswordController = TextEditingController();

  final isLoginLoading = false.obs;
  final isSignupLoading = false.obs;

  User? get currentUser => _authService.currentUser;
  void clearLoginFields() {
  loginEmailController.clear();
  loginPasswordController.clear();
}

void clearSignupFields() {
  signupNameController.clear();
  signupEmailController.clear();
  signupPasswordController.clear();
  signupConfirmPasswordController.clear();
}

  @override
  void onClose() {
    // loginEmailController.dispose();
    // loginPasswordController.dispose();
    // signupNameController.dispose();
    // signupEmailController.dispose();
    // signupPasswordController.dispose();
    // signupConfirmPasswordController.dispose();
    super.onClose();
  }

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your name';
    }
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email';
    }

    const pattern = r'^[^@\s]+@[^@\s]+\.[^@\s]+$';
    final regex = RegExp(pattern);

    if (!regex.hasMatch(value.trim())) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != signupPasswordController.text.trim()) {
      return 'Passwords do not match';
    }
    return null;
  }

  Future<void> login() async {
    final isValid = loginFormKey.currentState?.validate() ?? false;
    if (!isValid) return;

    try {
      isLoginLoading.value = true;

      await _authService.login(
        email: loginEmailController.text,
        password: loginPasswordController.text,
      );

      Get.offAllNamed(AppRoutes.home);

      Get.snackbar(
        'Success',
        'Logged in successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Login Failed',
        _mapFirebaseAuthError(e),
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (_) {
      Get.snackbar(
        'Login Failed',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoginLoading.value = false;
    }
  }

  Future<void> signUp() async {
    final isValid = signupFormKey.currentState?.validate() ?? false;
    if (!isValid) return;

    try {
      isSignupLoading.value = true;

      final credential = await _authService.signUp(
        email: signupEmailController.text,
        password: signupPasswordController.text,
      );

      await credential.user?.updateDisplayName(
        signupNameController.text.trim(),
      );

      Get.offAllNamed(AppRoutes.home);

      Get.snackbar(
        'Success',
        'Account created successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Sign Up Failed',
        _mapFirebaseAuthError(e),
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (_) {
      Get.snackbar(
        'Sign Up Failed',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isSignupLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      await _authService.logout();
      Get.offAllNamed(AppRoutes.welcome);
      Get.snackbar(
        'Logged out',
        'You have been logged out successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (_) {
      Get.snackbar(
        'Error',
        'Unable to logout right now',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  String _mapFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'Invalid email address';
      case 'user-not-found':
        return 'No account found with this email';
      case 'wrong-password':
      case 'invalid-credential':
        return 'Incorrect email or password';
      case 'email-already-in-use':
        return 'This email is already registered';
      case 'weak-password':
        return 'Password is too weak';
      case 'network-request-failed':
        return 'Please check your internet connection';
      default:
        return e.message ?? 'Authentication failed';
    }
  }
}