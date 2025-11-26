// lib/features/login/presentation/widgets/custom_text_field.dart

import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.isPassword = false, // 💡 إضافة باراميتر لتحديد ما إذا كان حقل كلمة مرور
  });

  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  // 💡 متغير لإدارة حالة إخفاء النص
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: widget.isPassword ? TextInputType.text : TextInputType.emailAddress,
      // 💡 تفعيل إخفاء النص إذا كان حقل كلمة مرور
      obscureText: widget.isPassword ? _isObscure : false,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xfffeebd6),
        labelText: widget.labelText,
        labelStyle: const TextStyle(color: Colors.grey, fontSize: 22),
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 20),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xfffeebd6),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.brown,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Colors.brown, width: 3),
        ),
        // 💡 إضافة أيقونة العين فقط لحقل كلمة المرور
        suffixIcon: widget.isPassword
            ? IconButton(
          icon: Icon(
            _isObscure ? Icons.visibility_off : Icons.visibility,
            color: Colors.brown,
          ),
          onPressed: () {
            setState(() {
              _isObscure = !_isObscure;
            });
          },
        )
            : null,
      ),
    );
  }
}