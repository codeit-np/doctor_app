import 'package:flutter/material.dart';

Widget inputText(TextEditingController controller, String labelText,
    IconData icon, bool obsecure, bool validate, TextInputType textInputType) {
  return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
      ),
      keyboardType: textInputType,
      obscureText: obsecure,
      validator: (value) => validate == true
          ? value.isEmpty
              ? 'This field is required'
              : null
          : null);
}
