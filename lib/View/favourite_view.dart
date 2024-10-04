// views/favorite_posts_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/Controller/favourite_controller.dart';
import 'package:test_project/View/home_page.dart';

class FavoritePostsView extends StatefulWidget {

  const FavoritePostsView({super.key, r});
  @override
  State<FavoritePostsView> createState() => _FavoritePostsViewState();
}

class _FavoritePostsViewState extends State<FavoritePostsView> {
  final FavoriteController favoriteController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    Future.microtask(()=>favoriteController.loadFavorites());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Posts'),
      ),
      body: Obx(() {
        if (favoriteController.favoritePosts.isEmpty) {
          return Center(child: Text('No favorite posts available'));
        }

        return ListView.builder(
          itemCount: favoriteController.favoritePosts.length,
          itemBuilder: (context, index) {
            final post = favoriteController.favoritePosts[index];
            return CardWidget(post: post, favoriteController: favoriteController,isFavourite: true,);
          },
        );
      }),
    );
  }
}
