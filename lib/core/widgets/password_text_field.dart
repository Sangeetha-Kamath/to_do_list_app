import 'package:flutter/material.dart';
import 'app_text_field.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.textInputAction,
    this.validator,
    this.onChanged,
  });

  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: widget.controller,
      hintText: widget.hintText ?? 'Enter your password',
      labelText: widget.labelText ?? 'Password',
      textInputAction: widget.textInputAction,
      obscureText: _obscureText,
      validator: widget.validator,
      onChanged: widget.onChanged,
      prefixIcon: const Icon(Icons.lock_outline),
      suffixIcon: IconButton(
        onPressed: _toggleVisibility,
        icon: Icon(
          _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
        ),
      ),
    );
  }
}