import 'package:get/get.dart';
import 'package:yessine/model/image_model.dart';

class DetailsController extends GetxController {
  // La fonction pour alterner l'état favori (isFavorite)
  void toggleFavorite(ImageModel image) {
    image.isFavorite.value = !image.isFavorite.value;
  }

  // La fonction pour augmenter/diminuer le nombre de "likes"
  void toggleLike(ImageModel image) {
    if (image.isFavorite.value) {
      // Si déjà aimé, on retire un like
      image.likes.value--;
    } else {
      // Si pas encore aimé, on ajoute un like
      image.likes.value++;
    }
    // Basculer l'état "aimé"
    image.isFavorite..value = !image.isFavorite.value;
  }
}
