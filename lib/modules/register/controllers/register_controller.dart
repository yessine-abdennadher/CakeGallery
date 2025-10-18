import 'package:get/get.dart';
import 'package:flutter/material.dart';

class RegisterController extends GetxController {
  // Cette méthode est appelée lorsqu'un utilisateur s'inscrit
  void createUser(String fullName, String email, String password, String confirmPassword) {
    // Ajoutez ici votre logique pour créer l'utilisateur, par exemple appeler un service API ou Firebase

    // Exemple simple de validation
    if (password == confirmPassword) {
      // Si les mots de passe correspondent, on procède à la création de l'utilisateur
      // Vous pouvez appeler ici un service d'authentification

      // Envoi de la notification de succès
      Get.snackbar(
        "Success",
        "Your account has been created successfully!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );

      // Naviguer vers la page de connexion
      Get.offAllNamed('/login'); // Rediriger vers la page de connexion
    } else {
      // Si les mots de passe ne correspondent pas, afficher une erreur
      Get.snackbar(
        "Error",
        "Passwords do not match.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
    }
  }
}
