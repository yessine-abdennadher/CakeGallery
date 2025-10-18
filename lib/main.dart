import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:yessine/modules/home/controllers/home_controller.dart';

import 'firebase_options.dart'; // Généré automatiquement par Firebase CLI
import 'modules/library/controllers/library_controller.dart';
import 'routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialisation de Firebase avec les options pour la plateforme en cours
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Assurez-vous que ce fichier existe et contient les bonnes options
  );


  Get.put(HomeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Named Routes Demo',
      debugShowCheckedModeBanner: false, // Désactive la bannière de débogage
      initialRoute: AppPages.INITIAL, // Définit la route initiale
      getPages: AppPages.routes, // Déclare les routes définies dans AppPages
    );
  }
}
