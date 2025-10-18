import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../home/views/home_view.dart';
import '../views/login_view.dart';

class LoginController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User?> _firebaseUser = Rx<User?>(null); // Initialisation avec null

  String? get user => _firebaseUser.value?.email; // Observables ont des valeurs

  @override
  void onInit() {
    // Lien de l'utilisateur Firebase avec le flux de l'état d'authentification
    _firebaseUser.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  // Création de l'utilisateur avec un email et un mot de passe
  void createUser(String email, String password) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .whenComplete(() {
        // Redirection vers la page d'accueil après création de l'utilisateur
        Get.offAll(HomeView());
      });
    } catch (error) {
      // Amélioration de la gestion des erreurs
      String errorMessage = _getErrorMessage(error);
      Get.snackbar(
        "Error Creating Account",
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Connexion de l'utilisateur avec un email et un mot de passe
  void login(String email, String password) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .whenComplete(() {
        // Redirection vers la page d'accueil après connexion réussie
        Get.offAll(HomeView());
      });
    } catch (error) {
      // Amélioration de la gestion des erreurs
      String errorMessage = _getErrorMessage(error);
      Get.snackbar(
        "Connect",
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  // Déconnexion de l'utilisateur
  void signOut() async {
    try {
      await _auth.signOut().whenComplete(() {
        // Redirection vers la page de connexion après déconnexion
        Get.offAll(LoginView());
      });
    } catch (error) {
      print("Error signing out: ${error.toString()}");
      Get.snackbar(
        "Error Signing Out",
        "An error occurred while signing out.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Fonction pour récupérer un message d'erreur adapté à partir de l'exception
  String _getErrorMessage(dynamic error) {
    if (error is FirebaseAuthException) {
      // Cas d'exception FirebaseAuth spécifique
      switch (error.code) {
        case 'email-already-in-use':
          return 'This email is already in use.';
        case 'invalid-email':
          return 'Invalid email format.';
        case 'weak-password':
          return 'Password should be at least 6 characters.';
        case 'user-not-found':
          return 'No user found with this email.';
        case 'wrong-password':
          return 'Incorrect password.';
        default:
          return 'An unknown error occurred.';
      }
    } else {
      // Pour d'autres types d'erreurs génériques
      return 'An error occurred. Please try again later.';
    }
  }
}
