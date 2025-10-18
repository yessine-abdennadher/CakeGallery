import 'package:get/get.dart';

class ImageModel {
  final String id;
  final String previewURL;
  final String user;
  final String tags;
  final RxInt likes;
  final int downloads;
  final RxBool isFavorite;
  final RxInt views;

  ImageModel({
    required this.id,
    required this.previewURL,
    required this.user,
    required this.tags,
    required int likes,
    required this.downloads,
    required int views,
    bool isFavorite = false,
  })  : likes = likes.obs,
        isFavorite = isFavorite.obs,
        views = views.obs;

  // Factory pour créer un objet `ImageModel` à partir d'un JSON
  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id']?.toString() ?? '',
      previewURL: json['previewURL']?.toString() ?? '',
      user: json['user']?.toString() ?? '',
      tags: json['tags']?.toString() ?? '',
      likes: (json['likes'] is int) ? json['likes'] : int.tryParse(json['likes']?.toString() ?? '0') ?? 0,
      downloads: (json['downloads'] is int) ? json['downloads'] : int.tryParse(json['downloads']?.toString() ?? '0') ?? 0,
      views: (json['views'] is int) ? json['views'] : int.tryParse(json['views']?.toString() ?? '0') ?? 0,
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  // Méthode pour convertir un objet en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'previewURL': previewURL,
      'user': user,
      'tags': tags,
      'likes': likes.value, // Utilisez la valeur de RxInt
      'downloads': downloads,
      'views': views.value, // Utilisez la valeur de RxInt
      'isFavorite': isFavorite.value, // Utilisez la valeur de RxBool
    };
  }
}
