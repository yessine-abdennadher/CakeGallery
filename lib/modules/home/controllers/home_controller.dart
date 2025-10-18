import 'package:get/get.dart';
import 'package:yessine/services/image_service.dart';
import '../../../model/image_model.dart';
import '../../library/controllers/library_controller.dart';

class HomeController extends GetxController {
  // Liste réactive des images
  RxList<ImageModel> images = <ImageModel>[].obs;

  // Liste des tags et tags sélectionnés
  RxList<String> tags = <String>[].obs;
  RxList<String> selectedTags = <String>[].obs;

  // Variable réactive pour le nom de l'utilisateur
  RxString username = "Yessine".obs;

  // Liste des images favorites
  RxList<ImageModel> favoriteImages = <ImageModel>[].obs;

  // Indicateur de chargement
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchImages();
  }

  // Récupérer les images depuis le service
  void fetchImages() async {
    // Si les images sont déjà en cours de chargement, ne pas effectuer une nouvelle requête
    if (isLoading.value) return;

    try {
      isLoading.value = true; // Indiquer que le chargement est en cours
      var fetchedImages = await ImageService.fetchImages();
      images.assignAll(fetchedImages); // Affectation des images récupérées

      // Extraire les tags uniques et les affecter à la liste des tags
      Set<String> uniqueTags = {};
      for (var image in images) {
        var imageTags = image.tags.split(', ').map((e) => e.trim()).toList();
        uniqueTags.addAll(imageTags);
      }
      tags.assignAll(uniqueTags.toList()); // Affecter les tags uniques à la liste `tags`

      print('Images chargées: ${images.length}');
      print('Tags récupérés: ${tags.length}');
    } catch (error) {
      print('Erreur lors du chargement des images: $error');
    } finally {
      isLoading.value = false; // Indiquer que le chargement est terminé
    }
  }

  // Fonction pour ajouter ou supprimer une image des favoris
  void toggleFavorite(ImageModel image) {
    // Inverse l'état du favori de l'image
    image.isFavorite.value = !image.isFavorite.value;
    print('Image ${image.id} mise à jour : favorite = ${image.isFavorite.value}');

    // Mise à jour des images favorites
    if (image.isFavorite.value) {
      favoriteImages.add(image);
    } else {
      favoriteImages.remove(image);
    }

    print('Images favorites mises à jour: ${favoriteImages.length}');
  }

  // Filtrage des images par tags sélectionnés
  List<ImageModel> get filteredImages {
    if (selectedTags.isEmpty) {
      return images;
    }
    return images.where((image) {
      final imageTags = image.tags.split(', ');
      return selectedTags.any((tag) => imageTags.contains(tag));
    }).toList();
  }
}
