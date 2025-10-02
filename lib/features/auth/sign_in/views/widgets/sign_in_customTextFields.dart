import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final bool isPassword;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isPassword ? _obscureText : false,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xFFFF7F3E)),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.black, width: 3),
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(color: Colors.grey[600]),
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon),
              const SizedBox(width: 8),
              Container(
                height: 24,
                width: 1,
                color: Colors.grey, // الخط الفاصل
              ),
            ],
          ),
        ),
        prefixIconColor: const Color(0xFFFF7F3E),

        // إذا كان Password، بنضيف الأيقونة
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: const Color(0xFFFF7F3E),
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText; // قلب الحالة
                  });
                },
              )
            : null,
      ),
      cursorColor: Colors.black,
    );
  }
}
