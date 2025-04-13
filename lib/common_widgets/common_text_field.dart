import 'package:flutter/material.dart';

class CommonTextField extends StatefulWidget {
  final String label;
  final String? Function(String?)? validator;
  final void Function(String) onChanged;
  final bool isPassword;
  final TextEditingController controller;
  final Function()? onTap;

  const CommonTextField({
    required this.label,
    required this.validator,
    required this.onChanged,
    this.isPassword = false,
    required this.controller,
    this.onTap,
  });

  @override
  _CommonTextFieldState createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassword ? _obscureText : false,
      decoration: InputDecoration(
        labelText: widget.label,
        border: OutlineInputBorder(),
        suffixIcon:
            widget.isPassword
                ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
                : null,
      ),
      validator: widget.validator,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
    );
  }
}
