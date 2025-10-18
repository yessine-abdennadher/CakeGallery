import 'package:get/get.dart';
import '../../../model/image_model.dart';
import '../../../services/image_service.dart';

class LibraryController extends GetxController {
  RxList<ImageModel> favoriteImages = <ImageModel>[].obs;
  RxList<ImageModel> images = <ImageModel>[].obs; // Liste des images de l'ensemble

  @override
  void onInit() {
    super.onInit();
    fetchImages();  // Charger les images au démarrage
  }

  // Récupérer toutes les images
  void fetchImages() async {
    var fetchedImages = await ImageService.fetchImages();
    images.assignAll(fetchedImages);
    print('Toutes les images chargées: ${images.length}');
  }

  // Récupérer les images favorites
  void fetchFavoriteImages() {
    favoriteImages.assignAll(images.where((image) => image.isFavorite.value).toList());

    // Debug
    print('Images favorites récupérées: ${favoriteImages.length}');
  }
  void debugFavoriteImages() {
    for (var image in favoriteImages) {
      print('Favorite Image ID: ${image.id}, Tags: ${image.tags}');
    }
  }
}


