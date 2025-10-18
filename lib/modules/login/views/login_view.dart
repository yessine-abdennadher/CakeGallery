import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_contoller.dart';
import '../../register/views/register_view.dart';

class LoginView extends GetWidget<LoginController> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    return Scaffold(
      backgroundColor: Colors.black, // Fond noir
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 70),
                child: Text(
                  "Welcome back!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Email Address",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 30, 30, 30), // Fond gris
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty || !value.contains('@')) {
                              return 'Please enter a valid email.';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          autofocus: false,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: 'Enter your email',
                            hintStyle: TextStyle(color: Colors.grey),
                            prefixIcon: Icon(Icons.person, color: Colors.grey),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(20),
                            errorStyle: TextStyle(
                              color: Colors.red,
                              fontSize: 14, // Style cohérent pour les erreurs
                            ),
                          ),
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => node.nextFocus(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Password",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 30, 30, 30), // Fond gris
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty || value.length < 6) {
                              return 'Password must be at least 6 characters.';
                            }
                            return null;
                          },
                          autofocus: false,
                          obscureText: true,
                          controller: passwordController,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: 'Enter your password',
                            hintStyle: TextStyle(color: Colors.grey),
                            prefixIcon: Icon(Icons.lock, color: Colors.grey),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(20),
                            errorStyle: TextStyle(
                              color: Colors.red,
                              fontSize: 14, // Style cohérent pour les erreurs
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                                controller.login(emailController.text, passwordController.text);
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
                              "Sign In",
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "New to the app?",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.to(RegisterView());
                            },
                            child: const Text(
                              'Create an account!',
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
            ],
          ),
        ),
      ),
    );
  }
}
