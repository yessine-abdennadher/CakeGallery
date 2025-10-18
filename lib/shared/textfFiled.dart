import "package:flutter/material.dart";

class MyTextField extends StatelessWidget {
  final bool isPassword;
  final TextEditingController controller;
  final String hintText;
  final TextInputType type;
  final Icon icon;

  const MyTextField({
    Key? key,
    required this.isPassword,
    required this.controller,
    this.hintText = '',
    this.type = TextInputType.text,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: type,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: icon,
        hintStyle: const TextStyle(color: Color.fromARGB(255, 241, 228, 228)),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 1.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.purpleAccent, width: 1.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      style: const TextStyle(color: Colors.white),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field cannot be empty';
        }
        return null;
      },
    );
  }
}
