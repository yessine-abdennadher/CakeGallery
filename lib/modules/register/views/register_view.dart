import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/register_controller.dart';

class RegisterView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Initialize the RegisterController
    final RegisterController controller = Get.put(RegisterController());

    return Scaffold(
      backgroundColor: Colors.black, // Fond noir
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Titre principal
                  const Text(
                    "Hello there!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Full Name Field
                  buildLabel("Full Name"),
                  buildTextField(
                    controller: fullNameController,
                    hintText: "Enter your full name",
                    prefixIcon: Icons.person,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  // Email Address Field
                  buildLabel("Email Address"),
                  buildTextField(
                    controller: emailController,
                    hintText: "Enter your email",
                    prefixIcon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  // Password Field
                  buildLabel("Password"),
                  buildTextField(
                    controller: passwordController,
                    hintText: "Enter your password",
                    prefixIcon: Icons.lock,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 6) {
                        return 'Password must be at least 6 characters.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  // Confirm Password Field
                  buildLabel("Confirm Password"),
                  buildTextField(
                    controller: confirmPasswordController,
                    hintText: "Re-enter your password",
                    prefixIcon: Icons.lock,
                    obscureText: true,
                    validator: (value) {
                      if (value != passwordController.text) {
                        return 'Passwords do not match.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  // Create Account Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Appeler la méthode createUser dans le controller
                          controller.createUser(
                            fullNameController.text,
                            emailController.text,
                            passwordController.text,
                            confirmPasswordController.text,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(134, 16, 253, 1),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Create an account",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already a member?",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.back(); // Retour à l'écran de connexion
                        },
                        child: const Text(
                          'Sign in!',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData prefixIcon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 30, 30, 30), // Fond gris foncé
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          prefixIcon: Icon(prefixIcon, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(20),
        ),
      ),
    );
  }
}
