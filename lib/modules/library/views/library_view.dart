import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../model/image_model.dart';
import '../../details/views/details_view.dart';
import '../../home/controllers/home_controller.dart';

class LibraryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtenir l'instance de HomeController
    final homeController = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Stack(
        children: [
          // Titre "Library"
          Positioned(
            left: 70,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
              child: Padding(
                padding: const EdgeInsets.only(top: 60, left: 20),
                child: const Text(
                  "Library",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          // Bouton retour
          Positioned(
            left: 20,
            top: 60,
            child: ElevatedButton(
              onPressed: () {
                Get.back();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  const Color.fromRGBO(98, 97, 97, 0.474),
                ),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.all(10),
                ),
                shape: MaterialStateProperty.all(
                  const CircleBorder(),
                ),
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Color.fromARGB(255, 120, 144, 156),
                size: 25,
              ),
            ),
          ),

          // Liste des favoris
          Padding(
            padding: const EdgeInsets.only(top: 150, left: 10, right: 11),
            child: Obx(() {
              if (homeController.favoriteImages.isEmpty) {
                return const Center(
                  child: Text(
                    'Aucune image trouvée',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3,
                  crossAxisSpacing: 13,
                  mainAxisSpacing: 13,
                ),
                itemCount: homeController.favoriteImages.length,
                itemBuilder: (BuildContext context, int index) {
                  ImageModel image = homeController.favoriteImages[index];

                  return GestureDetector(
                    onTap: () {
                      Get.to(() => DetailsView(image: image));
                    },
                    child: Stack(
                      children: [
                        // Image et nom de l'utilisateur
                        Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 120, 144, 156),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Image.network(
                                    image.previewURL,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    image.user,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 247, 247, 247),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Icône de favoris
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: image.isFavorite.value
                                  ? Colors.red
                                  : const Color.fromARGB(255, 120, 144, 156),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Icon(
                              image.isFavorite.value
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.white,
                              size: 24.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
