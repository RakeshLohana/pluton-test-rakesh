import 'package:get/get.dart';
import 'package:test_project/Model/ApiModel.dart';
import 'package:test_project/Service/local_db_service.dart';

class FavoriteController extends GetxController {
  var favoritePosts = <Posts>[].obs;
  final LocalDbService _localDbService = LocalDbService();




  Future<void> loadFavorites() async {
    final favorites = await _localDbService.getFavorites();
    favoritePosts.assignAll(favorites);
    update();
  }

  Future<void> addFavorite(Posts post) async {
    await _localDbService.addFavorite(post);
    favoritePosts.add(post);
    loadFavorites();
    Get.snackbar('Success', 'Added to favorites', snackPosition: SnackPosition.BOTTOM);
  }

  Future<void> removeFavorite(int id) async {
    await _localDbService.removeFavorite(id);
    favoritePosts.removeWhere((post) => post.id == id);
    loadFavorites();
    Get.snackbar('Success', 'Removed from favorites', snackPosition: SnackPosition.BOTTOM);
  }

  Future<bool> isFavorite(int id) async {
    loadFavorites();
    return await _localDbService.isFavorite(id);
  }
}
